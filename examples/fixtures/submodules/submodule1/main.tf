provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "submodule1_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.small"
}

resource "aws_ebs_volume" "submodule1_ebsvol" {
  availability_zone = "eu-west-1a"
  size              = 10
}
