# Using cost.modules.tf

This module gets cost estimation from `cost.modules.tf` service based on the provided content of Terraform state or plan file as json.

`cost.modules.tf` is entirely free cost estimation service, which is part of [modules.tf](https://modules.tf) that is currently in active development.

See [repository terraform-cost-estimation](https://github.com/antonbabenko/terraform-cost-estimation) and [terraform-cost-estimation.com](https://www.terraform-cost-estimation.com/) for more information. 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | >= 1.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.json_input](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.curl](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_data_source.costs](https://registry.terraform.io/providers/hashicorp/null/latest/docs/data-sources/data_source) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_content"></a> [content](#input\_content) | Content of tfstate or plan file as json | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to enable this module and call cost.modules.tf | `bool` | `true` | no |
| <a name="input_filename_hash"></a> [filename\_hash](#input\_filename\_hash) | Extra hash to add to created filenames | `string` | `""` | no |
| <a name="input_tmp_dir"></a> [tmp\_dir](#input\_tmp\_dir) | Name of local temp directory to create files in | `string` | `"tmp"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_costs"></a> [costs](#output\_costs) | Total costs |
| <a name="output_hourly"></a> [hourly](#output\_hourly) | Hourly costs |
| <a name="output_monthly"></a> [monthly](#output\_monthly) | Monthly costs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
