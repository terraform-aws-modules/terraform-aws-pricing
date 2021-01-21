# Using cost.modules.tf

This module gets cost estimation from `cost.modules.tf` service based on the provided content of Terraform state or plan file as json.

`cost.modules.tf` is entirely free cost estimation service, which is part of [modules.tf](https://modules.tf) that is currently in active development.

See [repository terraform-cost-estimation](https://github.com/antonbabenko/terraform-cost-estimation) and [terraform-cost-estimation.com](https://www.terraform-cost-estimation.com/) for more information. 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6 |
| aws | >= 3 |
| local | >= 1 |
| null | >= 2 |

## Providers

| Name | Version |
|------|---------|
| local | >= 1 |
| null | >= 2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| content | Content of tfstate or plan file as json | `string` | n/a | yes |
| enabled | Whether to enable this module and call cost.modules.tf | `bool` | `true` | no |
| filename\_hash | Extra hash to add to created filenames | `string` | `""` | no |
| tmp\_dir | Name of local temp directory to create files in | `string` | `"tmp"` | no |

## Outputs

| Name | Description |
|------|-------------|
| costs | Total costs |
| hourly | Hourly costs |
| monthly | Monthly costs |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
