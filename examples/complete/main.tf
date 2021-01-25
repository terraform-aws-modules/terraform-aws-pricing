provider "aws" {
  region = "us-east-1"
}

module "pricing" {
  source = "../../modules/pricing"

  debug_output = true

  aws_default_region = "eu-west-1"

  content = jsondecode(data.local_file.local_plan.content)

  resources = {
    "aws_instance.this#3" = { # 3 instances
      instanceType = "c5.xlarge"
      location     = "eu-west-2"
    }
    "aws_instance.this2" = {
      instanceType = "c4.xlarge"
      location     = "eu-central-1"
    }
  }
}

###########################
# Terraform plan (as JSON)
###########################
data "local_file" "local_plan" {
  filename = "../fixtures/etc/ec2.terraform.tfstate"
}
