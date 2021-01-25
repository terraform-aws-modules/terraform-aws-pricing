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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_default\_ebs\_volume\_size | Default size of EBS volume to use for resources (if not set) when asking AWS Pricing API | `number` | `100` | no |
| aws\_default\_ebs\_volume\_type | Default type of EBS volume to use for resources (if not set) when asking AWS Pricing API | `string` | `"gp2"` | no |
| aws\_default\_region | Default AWS region to use for resources (if not set) when asking AWS Pricing API | `string` | `"us-east-1"` | no |
| call\_aws\_pricing\_api | Whether to call AWS Pricing API for real or just output filter (it is useful to disable this to see filters instead of calling API) | `bool` | `true` | no |
| content | JSON object containing data of Terraform plan or state | `any` | `{}` | no |
| debug\_output | Whether to populate more output (useful for debug, but increase verbosity and size of tfstate) | `bool` | `false` | no |
| hourly\_price\_precision | Number of digits after comma in hourly price | `number` | `10` | no |
| monthly\_price\_precision | Number of digits after comma in monthly price | `number` | `2` | no |
| resources | Map of all resources to calculate price for | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_cli\_commands | AWS CLI commands identical to AWS Pricing API calls. This should always return value (preferably one value). Adjust filters accordingly. |
| input\_resources | Map of input resource filters (from plan/state or static) |
| pricing\_per\_resources | Map of resource pricing |
| pricing\_product\_filters | Map of pricing product filters (as they are submitted using data source `aws_pricing_product`) |
| resource\_quantity | Map of resource quantity |
| resources | Map of provided resources with filters |
| total\_price\_per\_hour | Total price for all resources per hour |
| total\_price\_per\_month | Total price for all resources per month (730 hours) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
