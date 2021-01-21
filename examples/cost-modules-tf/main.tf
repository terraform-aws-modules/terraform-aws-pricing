provider "aws" {
  region = "eu-west-1"
}

data "local_file" "tfstate" {
  filename = "../fixtures/ec2.terraform.tfstate"
}

module "tfstate" {
  source = "../../modules/cost.modules.tf"

  content = data.local_file.tfstate.content
}

data "terraform_remote_state" "local_state" {
  backend = "local"

  config = {
    path = "../fixtures/ec2.terraform.tfstate"
  }
}

module "tfstate_with_terraform_remote_state" {
  source = "../../modules/cost.modules.tf"

  content       = file(data.terraform_remote_state.local_state.config.path)
  filename_hash = "something"
}
