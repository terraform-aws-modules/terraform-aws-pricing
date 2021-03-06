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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6 |
| aws | >= 3 |
| local | >= 1 |

## Providers

| Name | Version |
|------|---------|
| local | >= 1 |
| terraform | n/a |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| pricing\_plan\_input\_resources | Map of input resource filters (from plan/state or static) |
| pricing\_plan\_pricing\_per\_resources | Map of resource pricing |
| pricing\_plan\_pricing\_product\_filters | Map of pricing product filters (as they are submitted using data source `aws_pricing_product`) |
| pricing\_plan\_resource\_quantity | Map of resource quantity |
| pricing\_plan\_resources | Map of provided resources with filters |
| pricing\_plan\_total\_price\_per\_hour | Total price for all resources |
| pricing\_plan\_total\_price\_per\_month | Total price for all resources per month (730 hours) |
| pricing\_state\_input\_resources | Map of input resource filters (from plan/state or static) |
| pricing\_state\_pricing\_per\_resources | Map of resource pricing |
| pricing\_state\_pricing\_product\_filters | Map of pricing product filters (as they are submitted using data source `aws_pricing_product`) |
| pricing\_state\_resource\_quantity | Map of resource quantity |
| pricing\_state\_resources | Map of provided resources with filters |
| pricing\_state\_total\_price\_per\_hour | Total price for all resources |
| pricing\_state\_total\_price\_per\_month | Total price for all resources per month (730 hours) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
