locals {

  # JSON object of plan or state as content
  input_type = length(keys(local.content)) == 0 ? "empty" : (contains(keys(local.content), "resources") ? "state" : "plan")

  # State - all resources are linear
  # Plan - combine root_module.resources and root_module.child_modules
  content_resources_state = local.input_type == "state" ? jsonencode(local.content.resources) : jsonencode({})
  content_resources_plan  = local.input_type == "plan" ? jsonencode(concat(lookup(local.content.planned_values.root_module, "resources", []), flatten(concat([for m in lookup(local.content.planned_values.root_module, "child_modules", {}) : m.resources])))) : jsonencode({})

  content_resources_string = local.input_type == "plan" ? local.content_resources_plan : local.content_resources_state

  content_resources = jsondecode(local.content_resources_string)

  # Removing resources which we don't support
  instances = [
    for r in local.content_resources :
    r
    if local.input_type != "empty" && length(lookup(r, "instances", ["plan-has-no-instances-key"])) > 0 && r.mode == "managed" && contains(keys(local.resource_types), r.type)
  ]

  # Normalize structure when input is "plan" into:
  # { "aws_instance.this.module.module_count_2[1].aws_instance.this[0]" = {
  #   "0" = {
  #     "_type" = "aws_instance"
  #     "instance_type" = "t2.nano"
  #   }
  # }
  normalized_plan_instances = local.input_type == "plan" ? {
    for v in local.instances :
    join(".", compact([v.type, v.name, v.address])) => {
      0 : (
        jsonencode(merge(v.values, { "_type" : v.type }))
      )
    }
  } : {}

  # Normalize structure when input is "state" into:
  # { "aws_instance.this.module.module_count_2[1]" = {
  # "0" = "{\"instance_type\":\"t2.nano\",\"_type\":\"aws_instance\"}"
  # }
  # Note:
  # v.attributes is an object which means we can't just `merge()` as we do for "plan"-case,
  # Error is produced "Invalid value for "v" parameter: cannot convert object to map of any single type."
  # The hacky solution is to call `jsonencode(v.attributes)` and append element "_type" as string to the end of the encoded object.
  normalized_state_instances = local.input_type == "state" ? {
    for i in local.instances :
    join(".", compact([i.type, i.name, lookup(i, "module", "")])) => {
      for v in i.instances :
      lookup(v, "index_key", 0) => (
        replace(jsonencode(v.attributes), "/}$/", ",\"_type\":\"${i.type}\"}")
      )
    }
  } : {}

  instances_map = local.input_type == "plan" ? local.normalized_plan_instances : local.normalized_state_instances

  instances_stripped_keys = local.input_type == "empty" ? [] : concat([
    for k, v in local.instances_map :
    setproduct([k], keys(v))
  ]...)

  # Prepare value to apply filters and transforms by jsondecoding values
  instances_map_fixed_keys = {
    for k in local.instances_stripped_keys :
    format("%s[%s]", k[0], k[1]) => (
      jsondecode(local.instances_map[k[0]][k[1]])
    )
    if try(length(regex(lookup(local.local_dev, "process_keys_regex", ".*"), k[0])) > 0, false)
  }


  # Extract filters from fields with type "list" into canonical structure
  extracted_filters_from_list_type_fields = merge(flatten([
    for k, v in local.instances_map_fixed_keys :
    [
      for field_k, field_v in v :
      [
        for num, item_fields in field_v :
        [
          for filter_k, filter_v in local.resource_types[v._type][field_k] : {
            join(".", [filter_v.new_resource_type, num, field_k, k]) : merge({
              "_type" : filter_v.new_resource_type
              }, {
              for i_k, i_v in lookup(filter_v, "map_values", {}) :
              i_k => lookup(item_fields, i_v, null)
            })
          }
          if lookup(filter_v, "required_field", null) == null || try(lookup(item_fields, lookup(filter_v, "required_field", null)), null) != null
        ]
      ]
      if !can(tostring(field_v)) && contains(keys(local.resource_types[v._type]), field_k)
    ]
  ])...)


  # Extract filters from fields with scalar type values (string, number) into canonical structure
  extracted_filters_from_scalar_type_fields = merge(flatten([
    for k, v in local.instances_map_fixed_keys :
    [
      for field_k, field_v in v :
      {
        for filter_k, filter_v in local.resource_types[v._type][field_k] :
        join(".", [filter_v.new_resource_type, filter_k, field_k, k]) => merge({
          "_type" : filter_v.new_resource_type
          }, {
          for i_k, i_v in lookup(filter_v, "map_values", {}) :
          i_k => lookup(local.instances_map_fixed_keys[k], i_v, null)
        })
        if lookup(filter_v, "required_field", null) == null || try(lookup(local.instances_map_fixed_keys[k], lookup(filter_v, "required_field", null)), null) != null
      }
      if can(tostring(field_v)) && contains(keys(local.resource_types[v._type]), field_k) && try(length(local.resource_types[v._type][field_k][0].new_resource_type) > 0, false)
    ]
  ])...)


  # Remove irrelevant attributes (for main filter) and after filter has been expanded into separate resource (eg, EBS volume from EC2 instances)
  instance_details_filtered = {
    for k, v in local.instances_map_fixed_keys :
    k => {
      for field_k, field_v in v :
      field_k => field_v
      if contains(concat(keys(local.resource_types[v._type]), ["_type"]), field_k) && try(length(local.resource_types[v._type][field_k][0]) == 0, true)
    }
  }


  # Merge all extracted filters
  all_details = merge(local.instance_details_filtered, local.extracted_filters_from_list_type_fields, local.extracted_filters_from_scalar_type_fields)

  # Transform field values and store with correct filter names as key
  instance_filters = {
    for k, v in local.all_details :
    k => {
      for field_k, field_v in v :
      lookup(local.resource_types[v._type][field_k], "filter", field_k) => (

        # get_region_from_arn
        lookup(local.resource_types[v._type][field_k], "transformer", null) == "get_region_from_arn" ? try(split(":", field_v)[3], var.aws_default_region) :

        # get_region_from_arn_with_lookup_lb_usagetype
        lookup(local.resource_types[v._type][field_k], "transformer", null) == "get_region_from_arn_with_lookup_lb_usagetype" ? lookup(local.lb_usagetype, try(split(":", field_v)[3], var.aws_default_region), "LoadBalancerUsage") :

        # get_region_from_arn_with_lookup_ebs_snapshot_usagetype
        lookup(local.resource_types[v._type][field_k], "transformer", null) == "get_region_from_arn_with_lookup_ebs_snapshot_usagetype" ? lookup(local.ebs_snapshot_usagetype, var.aws_default_region, "EBS:SnapshotUsage") :

        # cut_region_from_availability_zone
        lookup(local.resource_types[v._type][field_k], "transformer", null) == "get_region_from_availability_zone" ? try(substr(field_v, 0, length(field_v) - 1), var.aws_default_region) :

        # get_instance_tenancy
        lookup(local.resource_types[v._type][field_k], "transformer", null) == "get_instance_tenancy" ? (field_v == "dedicated" ? "Dedicated" : "Shared") :

        # get_load_balancer_type
        lookup(local.resource_types[v._type][field_k], "transformer", null) == "get_load_balancer_type" ? (field_v == "application" ? "Load Balancer-Application" : "Load Balancer-Network") :

        # get_db_instance_engine
        lookup(local.resource_types[v._type][field_k], "transformer", null) == "get_db_instance_engine" ? (lookup(local.db_instance_engine, field_v)) :

        # get_db_instance_engine_edition
        lookup(local.resource_types[v._type][field_k], "transformer", null) == "get_db_instance_engine_edition" ? (lookup(local.db_instance_engine_edition, local.all_details[k]["engine"], null)) :

        # get_multi_az
        lookup(local.resource_types[v._type][field_k], "transformer", null) == "get_multi_az" ? (field_v == true ? "Multi-AZ" : "Single-AZ") :

        # Check if value is null -> use default value for this resource
        field_v == null && contains(keys(local.resource_defaults[v._type]), lookup(local.resource_types[v._type][field_k], "filter", field_k)) ? lookup(local.resource_defaults[v._type], lookup(local.resource_types[v._type][field_k], "filter", field_k), "Missing default value") :

        # Default, field_v can be string or list (jsonencode to string for certainty)
        try(tostring(field_v), jsonencode(field_v))

      ) if contains(keys(local.resource_types[v._type]), field_k)
    }
  }

  # Remove keys where filter's value is null
  instance_final_filters = {
    for k, v in local.instance_filters :
    k => {
      for filter_k, filter_v in v :
      filter_k => filter_v
      if filter_v != null
    }
  }

}
