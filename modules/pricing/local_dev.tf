locals {
  local_dev = {
    #    debug_output         = true
    #    call_aws_pricing_api = true
    #    run_aws_cli_commands = false

    # Regex to select subset of keys to work with:
    #    process_keys_regex = "aws_db_instance"

    #    content = jsondecode(data.local_file.local_plan.content)
  }
}
#
########
## Run aws_cli response to check results.
##    jq -r ".PriceList[0] | fromjson
##    jq -r ".PriceList[0] | fromjson | .terms.OnDemand[].priceDimensions[].pricePerUnit.USD"
########
#resource "null_resource" "aws_cli" {
#  for_each = local.run_aws_cli_commands ? local.aws_cli_commands : {}
#
#  triggers = {
#    trigger = timestamp()
#  }
#
#  provisioner "local-exec" {
#    command = each.value
#  }
#}
#
############################
## Terraform plan (as JSON)
############################
#data "local_file" "local_plan" {
#  filename = "../../examples/fixtures/all-resources/plan.json"
#
#  #  filename = "../../examples/fixtures/etc/plan-ebs-volume.json" # scalar
#
#  #  filename = "../../examples/fixtures/etc/plan-ebs.json"   # list(map) => local.extracted_filters_in_instances_multiple
#
#
#  #  filename = "../../examples/fixtures/etc/plan-instance-with-multiple-ebs.json"
#  #  filename = "../../examples/fixtures/etc/ebs-terraform-state.json"
#  #  filename = "../../examples/fixtures/etc/plan-lb-and-nat.json"
#  #  filename = "../../examples/fixtures/etc/ec2.terraform.tfstate"
#
#  #  filename = "../../examples/fixtures/combinations/plan.json"
#  #  filename = "../../examples/fixtures/combinations/terraform.tfstate"
#}
