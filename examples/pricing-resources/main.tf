provider "aws" {
  region = "us-east-1"
}

module "pricing" {
  source = "../../modules/pricing"

  debug_output = true

  resources = {
    "aws_instance.this#3" = { # 3 instances
      instanceType = "c5.xlarge"
      location     = "eu-west-2"
    }
    "aws_instance.this2" = {
      instanceType = "t3.large"
      location     = "ap-southeast-3"
    }
  }
}
