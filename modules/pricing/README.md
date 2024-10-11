# AWS Pricing module

This module gets cost estimation for AWS infrastructure by calling AWS Pricing API and aggregating results.

## What is supported as input?

`var.content`:
1. Content of Terraform state file (as JSON)
2. Content of Terraform plan file (as JSON)

`var.resources`:
1. Map of resources with pricing filters

## How it works?

`state_and_plan_content_from_json.tf` - Content of state and plan file is normalized to the canonical structure which is compatible to the one defined as `var.resources`.

### Approximate order of execution:

1. `filters.tf` + `regions.tf` + `variables.tf`
2. `state_and_plan_content_from_json.tf`
3. `main.tf`
4. `outputs.tf`

## How to extend? How to contribute?

`filters.tf` contains all AWS Pricing filters for supported resources. It is the main place to
add support for new types of resources.

`regions.tf` contains logic for expanding AWS regions map which is expected by Pricing API.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_pricing_product.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/pricing_product) | data source |
| [aws_region.one](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_regions.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_default_ebs_volume_size"></a> [aws\_default\_ebs\_volume\_size](#input\_aws\_default\_ebs\_volume\_size) | Default size of EBS volume to use for resources (if not set) when asking AWS Pricing API | `number` | `100` | no |
| <a name="input_aws_default_ebs_volume_type"></a> [aws\_default\_ebs\_volume\_type](#input\_aws\_default\_ebs\_volume\_type) | Default type of EBS volume to use for resources (if not set) when asking AWS Pricing API | `string` | `"gp2"` | no |
| <a name="input_aws_default_region"></a> [aws\_default\_region](#input\_aws\_default\_region) | Default AWS region to use for resources (if not set) when asking AWS Pricing API | `string` | `"us-east-1"` | no |
| <a name="input_call_aws_pricing_api"></a> [call\_aws\_pricing\_api](#input\_call\_aws\_pricing\_api) | Whether to call AWS Pricing API for real or just output filter (it is useful to disable this to see filters instead of calling API) | `bool` | `true` | no |
| <a name="input_content"></a> [content](#input\_content) | JSON object containing data of Terraform plan or state | `any` | `{}` | no |
| <a name="input_debug_output"></a> [debug\_output](#input\_debug\_output) | Whether to populate more output (useful for debug, but increase verbosity and size of tfstate) | `bool` | `false` | no |
| <a name="input_hourly_price_precision"></a> [hourly\_price\_precision](#input\_hourly\_price\_precision) | Number of digits after comma in hourly price | `number` | `10` | no |
| <a name="input_monthly_price_precision"></a> [monthly\_price\_precision](#input\_monthly\_price\_precision) | Number of digits after comma in monthly price | `number` | `2` | no |
| <a name="input_query_all_regions"></a> [query\_all\_regions](#input\_query\_all\_regions) | If true the source will query all regions regardless of availability | `bool` | `true` | no |
| <a name="input_resources"></a> [resources](#input\_resources) | Map of all resources to calculate price for | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_cli_commands"></a> [aws\_cli\_commands](#output\_aws\_cli\_commands) | AWS CLI commands identical to AWS Pricing API calls. This should always return value (preferably one value). Adjust filters accordingly. |
| <a name="output_input_resources"></a> [input\_resources](#output\_input\_resources) | Map of input resource filters (from plan/state or static) |
| <a name="output_pricing_per_resources"></a> [pricing\_per\_resources](#output\_pricing\_per\_resources) | Map of resource pricing |
| <a name="output_pricing_product_filters"></a> [pricing\_product\_filters](#output\_pricing\_product\_filters) | Map of pricing product filters (as they are submitted using data source `aws_pricing_product`) |
| <a name="output_resource_quantity"></a> [resource\_quantity](#output\_resource\_quantity) | Map of resource quantity |
| <a name="output_resources"></a> [resources](#output\_resources) | Map of provided resources with filters |
| <a name="output_total_price_per_hour"></a> [total\_price\_per\_hour](#output\_total\_price\_per\_hour) | Total price for all resources per hour |
| <a name="output_total_price_per_month"></a> [total\_price\_per\_month](#output\_total\_price\_per\_month) | Total price for all resources per month (730 hours) |
<!-- END_TF_DOCS -->
