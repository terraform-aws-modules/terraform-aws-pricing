locals {
  costs = var.enabled ? jsondecode(file(data.null_data_source.costs[0].outputs["cost_filename"])) : tomap({})
}

output "costs" {
  description = "Total costs"
  value       = local.costs
}

output "hourly" {
  description = "Hourly costs"
  value       = lookup(local.costs, "hourly", 0)
}

output "monthly" {
  description = "Monthly costs"
  value       = lookup(local.costs, "monthly", 0)
}
