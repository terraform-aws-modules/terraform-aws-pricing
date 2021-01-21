output "pricing_resources" {
  description = "Map of provided resources with filters"
  value       = module.pricing.resources
}

output "pricing_input_resources" {
  description = "Map of input resource filters (from plan/state or static)"
  value       = module.pricing.input_resources
}

output "pricing_pricing_product_filters" {
  description = "Map of pricing product filters (as they are submitted using data source `aws_pricing_product`)"
  value       = module.pricing.pricing_product_filters
}

output "pricing_resource_quantity" {
  description = "Map of resource quantity"
  value       = module.pricing.resource_quantity
}

output "pricing_pricing_per_resources" {
  description = "Map of resource pricing"
  value       = module.pricing.pricing_per_resources
}

output "pricing_total_price_per_hour" {
  description = "Total price for all resources"
  value       = module.pricing.total_price_per_hour
}

output "pricing_total_price_per_month" {
  description = "Total price for all resources per month (730 hours)"
  value       = module.pricing.total_price_per_month
}
