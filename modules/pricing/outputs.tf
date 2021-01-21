locals {
  pricing_results = { for k, v in data.aws_pricing_product.this : k => jsondecode(v.result) }

  pricing_per_resources = { for k, v in local.pricing_results : k => tonumber(values(values(v.terms.OnDemand)[0].priceDimensions)[0].pricePerUnit.USD) }

  # Trying to calculate sum of an empty list
  total_price = try(sum([for k, v in local.pricing_per_resources : v * lookup(local.resource_quantity, k, 1)]), 0)
}

output "resources" {
  description = "Map of provided resources with filters"
  value       = var.debug_output ? local.resources : {}
}

output "input_resources" {
  description = "Map of input resource filters (from plan/state or static)"
  value       = var.debug_output ? local.input_resources : {}
}

output "pricing_product_filters" {
  description = "Map of pricing product filters (as they are submitted using data source `aws_pricing_product`)"
  value       = var.debug_output ? local.pricing_product_filters : {}
}

output "resource_quantity" {
  description = "Map of resource quantity"
  value       = local.resource_quantity
}

output "aws_region_descriptions" {
  description = "Map of supported AWS regions after conversion for pricing API"
  value       = var.debug_output ? local.all_aws_regions : {}
}

output "pricing_per_resources" {
  description = "Map of resource pricing"
  value       = local.pricing_per_resources
}

output "total_price_per_hour" {
  description = "Total price for all resources per hour"
  value       = tonumber(format("%.2f", local.total_price))
}

output "total_price_per_month" {
  description = "Total price for all resources per month (730 hours)"
  value       = tonumber(format("%.2f", local.total_price * 730))
}
