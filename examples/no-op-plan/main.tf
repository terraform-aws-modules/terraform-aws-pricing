provider "aws" {
  region = "us-east-1"
}

module "pricing_plan" {
  source = "../../modules/pricing"

  #  debug_output = true

  content = jsondecode(data.local_file.local_plan.content)

}

###########################
# Terraform plan (as JSON)
###########################
data "local_file" "local_plan" {
  filename = "../fixtures/no-op/plan.json"
}
