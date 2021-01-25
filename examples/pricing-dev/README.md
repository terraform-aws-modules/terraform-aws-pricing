# Pricing playground to verify multiple fixtures easily

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
| terraform | >= 0.13 |
| aws | >= 3 |
| local | >= 1 |

## Providers

| Name | Version |
|------|---------|
| local | >= 1 |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| aws\_cli\_commands | List of AWS CLI commands with Pricing filters |
| pricing\_input\_resources | Map of input resource filters (from plan/state or static) |
| pricing\_pricing\_per\_resources | Map of resource pricing |
| pricing\_pricing\_product\_filters | Map of pricing product filters (as they are submitted using data source `aws_pricing_product`) |
| pricing\_resource\_quantity | Map of resource quantity |
| pricing\_resources | Map of provided resources with filters |
| pricing\_total\_price\_per\_hour | Total price for all resources |
| pricing\_total\_price\_per\_month | Total price for all resources per month (730 hours) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
