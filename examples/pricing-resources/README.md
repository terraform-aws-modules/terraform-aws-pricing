# Infrastructure costs for AWS resources (static)

Configuration in this directory calculates AWS infrastructure costs for specified AWS resources.

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

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_pricing"></a> [pricing](#module\_pricing) | ../../modules/pricing | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_input_resources"></a> [input\_resources](#output\_input\_resources) | Map of input resource filters (from plan/state or static) |
| <a name="output_pricing_per_resources"></a> [pricing\_per\_resources](#output\_pricing\_per\_resources) | Map of resource pricing |
| <a name="output_pricing_product_filters"></a> [pricing\_product\_filters](#output\_pricing\_product\_filters) | Map of pricing product filters (as they are submitted using data source `aws_pricing_product`) |
| <a name="output_resource_quantity"></a> [resource\_quantity](#output\_resource\_quantity) | Map of resource quantity |
| <a name="output_resources"></a> [resources](#output\_resources) | Map of provided resources with filters |
| <a name="output_total_price_per_hour"></a> [total\_price\_per\_hour](#output\_total\_price\_per\_hour) | Total price for all resources |
| <a name="output_total_price_per_month"></a> [total\_price\_per\_month](#output\_total\_price\_per\_month) | Total price for all resources per month (730 hours) |
<!-- END_TF_DOCS -->
