output "price_tfstate" {
  description = "Costs for local file - state"
  value       = module.tfstate.costs
}

output "price_tfstate_with_terraform_remote_state" {
  description = "Costs for remote state"
  value       = module.tfstate_with_terraform_remote_state.costs
}

output "price_plan" {
  description = "Costs for local file - plan"
  value       = module.plan.costs
}
