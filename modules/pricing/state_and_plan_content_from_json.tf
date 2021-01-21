locals {

  # JSON object of plan or state as content
  content = var.content

  input_type = length(keys(local.content)) == 0 ? "empty" : (contains(keys(local.content), "resources") ? "state" : "plan")

  # State - all resources are linear
  # Plan - combine root_module.resources and root_module.child_modules
  content_resources_state = local.input_type == "state" ? jsonencode(local.content.resources) : jsonencode({})
  content_resources_plan  = local.input_type == "plan" ? jsonencode(concat(local.content.planned_values.root_module.resources, flatten(concat([for m in local.content.planned_values.root_module.child_modules : m.resources])))) : jsonencode({})

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
  }

  # Remove irrelevant attributes (later: create new resources (eg, EBS volume from EC2 instaces))
  instance_details_filtered = {
    for k, v in local.instances_map_fixed_keys :
    k => {
      for field_k, field_v in v :
      field_k => field_v
      if contains(concat(keys(local.resource_types[v._type]), ["_type"]), field_k)
    }
  }

  # Transform field values and store with correct filter names as key
  instance_final_filters = {
    for k, v in local.instance_details_filtered :
    k => {
      for field_k, field_v in v :
      lookup(local.resource_types[v._type][field_k], "filter", field_k) => (
        lookup(local.resource_types[v._type][field_k], "transformer", null) == "get_region_from_arn" ? try(split(":", field_v)[3], var.aws_default_region) : try(tostring(field_v), jsonencode(field_v)) # field_v can be string or list
      ) if contains(keys(local.resource_types[v._type]), field_k)
    }
  }

  # Add required filters with the default values to prevent API errors like:
  # Pricing product query not precise enough. Returned more than one element.
  # This is implemented at later stage when combining it with resource_defaults
  #  instance_details_with_defaults_added = {
  #    for k, v in local.instance_details_transformed :
  #    k => (
  #      merge(v, lookup(local.resource_types[v._type], "_default_filters", {}))
  #    )
  #  }

  # Remove "_type" from filters, finally!
  #  instance_final_filters = {
  #    for k, v in local.instance_details_transformed :
  #    k => {
  #      for field_k, field_v in v :
  #      field_k => field_v
  #      if field_k != "_type"
  #    }
  #  }

}
