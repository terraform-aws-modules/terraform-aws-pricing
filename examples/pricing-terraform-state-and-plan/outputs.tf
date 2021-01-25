#output "calculation_check" {
#  description = "Costs for both plan and state should match"
#  value       = module.pricing_plan.total_price_per_month == module.pricing_all_together_state.total_price_per_month
#}

#################
# Terraform plan
#################
output "pricing_plan_resources" {
  description = "Map of provided resources with filters"
  value       = module.pricing_plan.resources
}

output "pricing_plan_input_resources" {
  description = "Map of input resource filters (from plan/state or static)"
  value       = module.pricing_plan.input_resources
}

output "pricing_plan_pricing_product_filters" {
  description = "Map of pricing product filters (as they are submitted using data source `aws_pricing_product`)"
  value       = module.pricing_plan.pricing_product_filters
}

output "pricing_plan_resource_quantity" {
  description = "Map of resource quantity"
  value       = module.pricing_plan.resource_quantity
}

output "pricing_plan_pricing_per_resources" {
  description = "Map of resource pricing"
  value       = module.pricing_plan.pricing_per_resources
}

output "pricing_plan_total_price_per_hour" {
  description = "Total price for all resources"
  value       = module.pricing_plan.total_price_per_hour
}

output "pricing_plan_total_price_per_month" {
  description = "Total price for all resources per month (730 hours)"
  value       = module.pricing_plan.total_price_per_month
}

##################
# Terraform state
##################
output "pricing_state_resources" {
  description = "Map of provided resources with filters"
  value       = module.pricing_state.resources
}

output "pricing_state_input_resources" {
  description = "Map of input resource filters (from plan/state or static)"
  value       = module.pricing_state.input_resources
}

output "pricing_state_pricing_product_filters" {
  description = "Map of pricing product filters (as they are submitted using data source `aws_pricing_product`)"
  value       = module.pricing_state.pricing_product_filters
}

output "pricing_state_resource_quantity" {
  description = "Map of resource quantity"
  value       = module.pricing_state.resource_quantity
}

output "pricing_state_pricing_per_resources" {
  description = "Map of resource pricing"
  value       = module.pricing_state.pricing_per_resources
}

output "pricing_state_total_price_per_hour" {
  description = "Total price for all resources"
  value       = module.pricing_state.total_price_per_hour
}

output "pricing_state_total_price_per_month" {
  description = "Total price for all resources per month (730 hours)"
  value       = module.pricing_state.total_price_per_month
}
