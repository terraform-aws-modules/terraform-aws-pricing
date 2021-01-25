provider "aws" {
  region = "eu-west-1"
}

##################
# Terraform state
##################

data "local_file" "tfstate" {
  filename = "../fixtures/etc/ec2.terraform.tfstate"
}

module "tfstate" {
  source = "../../modules/cost.modules.tf"

  content = data.local_file.tfstate.content
}

data "terraform_remote_state" "local_state" {
  backend = "local"

  config = {
    path = "../fixtures/etc/ec2.terraform.tfstate"
  }
}

module "tfstate_with_terraform_remote_state" {
  source = "../../modules/cost.modules.tf"

  content       = file(data.terraform_remote_state.local_state.config.path)
  filename_hash = "something"
}

#################
# Terraform plan
#################

data "local_file" "plan" {
  filename = "../../examples/fixtures/all-resources/plan.json"
}

module "plan" {
  source = "../../modules/cost.modules.tf"

  content = data.local_file.plan.content
}
