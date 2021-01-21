output "price_tfstate" {
  description = "Costs for local file"
  value       = module.tfstate.costs
}

output "price_tfstate_with_terraform_remote_state" {
  description = "Costs for remote state"
  value       = module.tfstate_with_terraform_remote_state.costs
}
