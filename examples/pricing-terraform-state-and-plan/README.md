# Infrastructure costs from Terraform state and plan (as JSON)

Configuration in this directory calculates AWS infrastructure costs for specified Terraform state and plan (as JSON file).

Note that AWS provider should always be set to `us-east-1` or `ap-south-1` region.

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
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
| <a name="module_pricing_plan"></a> [pricing\_plan](#module\_pricing\_plan) | ../../modules/pricing | n/a |
| <a name="module_pricing_state"></a> [pricing\_state](#module\_pricing\_state) | ../../modules/pricing | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.local_plan](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [terraform_remote_state.local_state](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pricing_plan_input_resources"></a> [pricing\_plan\_input\_resources](#output\_pricing\_plan\_input\_resources) | Map of input resource filters (from plan/state or static) |
| <a name="output_pricing_plan_pricing_per_resources"></a> [pricing\_plan\_pricing\_per\_resources](#output\_pricing\_plan\_pricing\_per\_resources) | Map of resource pricing |
| <a name="output_pricing_plan_pricing_product_filters"></a> [pricing\_plan\_pricing\_product\_filters](#output\_pricing\_plan\_pricing\_product\_filters) | Map of pricing product filters (as they are submitted using data source `aws_pricing_product`) |
| <a name="output_pricing_plan_resource_quantity"></a> [pricing\_plan\_resource\_quantity](#output\_pricing\_plan\_resource\_quantity) | Map of resource quantity |
| <a name="output_pricing_plan_resources"></a> [pricing\_plan\_resources](#output\_pricing\_plan\_resources) | Map of provided resources with filters |
| <a name="output_pricing_plan_total_price_per_hour"></a> [pricing\_plan\_total\_price\_per\_hour](#output\_pricing\_plan\_total\_price\_per\_hour) | Total price for all resources |
| <a name="output_pricing_plan_total_price_per_month"></a> [pricing\_plan\_total\_price\_per\_month](#output\_pricing\_plan\_total\_price\_per\_month) | Total price for all resources per month (730 hours) |
| <a name="output_pricing_state_input_resources"></a> [pricing\_state\_input\_resources](#output\_pricing\_state\_input\_resources) | Map of input resource filters (from plan/state or static) |
| <a name="output_pricing_state_pricing_per_resources"></a> [pricing\_state\_pricing\_per\_resources](#output\_pricing\_state\_pricing\_per\_resources) | Map of resource pricing |
| <a name="output_pricing_state_pricing_product_filters"></a> [pricing\_state\_pricing\_product\_filters](#output\_pricing\_state\_pricing\_product\_filters) | Map of pricing product filters (as they are submitted using data source `aws_pricing_product`) |
| <a name="output_pricing_state_resource_quantity"></a> [pricing\_state\_resource\_quantity](#output\_pricing\_state\_resource\_quantity) | Map of resource quantity |
| <a name="output_pricing_state_resources"></a> [pricing\_state\_resources](#output\_pricing\_state\_resources) | Map of provided resources with filters |
| <a name="output_pricing_state_total_price_per_hour"></a> [pricing\_state\_total\_price\_per\_hour](#output\_pricing\_state\_total\_price\_per\_hour) | Total price for all resources |
| <a name="output_pricing_state_total_price_per_month"></a> [pricing\_state\_total\_price\_per\_month](#output\_pricing\_state\_total\_price\_per\_month) | Total price for all resources per month (730 hours) |
<!-- END_TF_DOCS -->
