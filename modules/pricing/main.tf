locals {
  # Merge inputs:
  # 1. Extracted resource filters from state or plan
  # 2. Static resources
  input_resources = merge(local.instance_final_filters, var.resources)

  # resources_combined = resources + resource_defaults
  resources_combined = {
    for k, v in local.input_resources :
    k => (
      merge(local.resource_defaults[split(".", k)[0]], v)
    )
  }

  # apply/reformat location values in resources_combined
  resources_location = {
    for k, v in local.resources_combined : k => {
      for k1, v1 in v :
      k1 => (
        matchkeys(keys(local.all_aws_regions), values(local.all_aws_regions), [v1])[0]
      ) if k1 == "location"
    }
  }

  # resources = resources_combined + resources_location
  resources = {
    for k, v in local.resources_combined :
    k => (
      merge(local.resources_combined[k], local.resources_location[k])
    )
  }

  # Quantity of individual resources
  resource_quantity = {
    for k, v in local.resources :
    k => (
      tonumber(try(split("#", k)[1], 1))
    )
  }

  # Final AWS Pricing Product filters as they will be send to API and/or output for debug
  pricing_product_filters = {
    for k, v in local.resources :
    k => {
      service_code : local.resources_service_code[split(".", k)[0]]
      filters : v
    }
  }
}

data "aws_pricing_product" "this" {
  # @todo: Change a key to be composite of all keys, so that during reapply everything resets
  for_each = var.call_aws_pricing_api ? local.pricing_product_filters : {}

  service_code = each.value.service_code

  dynamic "filters" {
    for_each = each.value.filters

    content {
      field = filters.key
      value = filters.value
    }
  }
}
