provider "aws" {
  region = "us-east-1"
}

###########################
# Terraform plan (as JSON)
###########################
data "local_file" "local_plan" {
  filename = "../../examples/fixtures/all-resources/plan.json"
  #  filename = "../fixtures/ec2-various/ebs-terraform-state.json"
  #  filename = "../fixtures/ec2-various/plan-lb-and-nat.json"
}

module "pricing" {
  source = "../../modules/pricing"

  debug_output         = true
  call_aws_pricing_api = false

  aws_default_region = "af-south-1"

  content = jsondecode(data.local_file.local_plan.content)
}

#######
# Run aws_cli response to check results by running ../../dev/calculate_results.sh
#######
#locals {
#  run_aws_cli_commands = false
#}
#
#resource "null_resource" "aws_cli" {
#  for_each = local.run_aws_cli_commands ? module.pricing.aws_cli_commands : {}
#
#  triggers = {
#    trigger = timestamp()
#  }
#
#  provisioner "local-exec" {
#    command = each.value
#  }
#}
