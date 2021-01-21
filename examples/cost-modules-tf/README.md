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
| price\_tfstate | Costs for local file |
| price\_tfstate\_with\_terraform\_remote\_state | Costs for remote state |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
