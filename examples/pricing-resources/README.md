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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6 |
| aws | >= 3 |

## Providers

No provider.

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| input\_resources | Map of input resource filters (from plan/state or static) |
| pricing\_per\_resources | Map of resource pricing |
| pricing\_product\_filters | Map of pricing product filters (as they are submitted using data source `aws_pricing_product`) |
| resource\_quantity | Map of resource quantity |
| resources | Map of provided resources with filters |
| total\_price\_per\_hour | Total price for all resources |
| total\_price\_per\_month | Total price for all resources per month (730 hours) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
