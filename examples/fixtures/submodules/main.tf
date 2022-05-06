provider "aws" {
  region = "eu-west-1"
}

#######################################################
# aws_instance and submodule
#######################################################

resource "aws_instance" "root_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.small"
}

module "asubmodule" {
  source = "./submodule1"
}
