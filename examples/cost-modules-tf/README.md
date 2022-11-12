# cost.modules.tf example

Configuration in this directory sends `terraform.tfstate` file content to `cost.modules.tf` to calculate AWS infrastructure costs.

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | >= 1.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_plan"></a> [plan](#module\_plan) | ../../modules/cost.modules.tf | n/a |
| <a name="module_tfstate"></a> [tfstate](#module\_tfstate) | ../../modules/cost.modules.tf | n/a |
| <a name="module_tfstate_with_terraform_remote_state"></a> [tfstate\_with\_terraform\_remote\_state](#module\_tfstate\_with\_terraform\_remote\_state) | ../../modules/cost.modules.tf | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.plan](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [local_file.tfstate](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [terraform_remote_state.local_state](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_price_plan"></a> [price\_plan](#output\_price\_plan) | Costs for local file - plan |
| <a name="output_price_tfstate"></a> [price\_tfstate](#output\_price\_tfstate) | Costs for local file - state |
| <a name="output_price_tfstate_with_terraform_remote_state"></a> [price\_tfstate\_with\_terraform\_remote\_state](#output\_price\_tfstate\_with\_terraform\_remote\_state) | Costs for remote state |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
