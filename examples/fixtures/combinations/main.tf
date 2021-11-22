provider "aws" {
  region = "eu-west-1"
}

##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}

module "instance_count_2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name          = "instance_count_"
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = element(data.aws_subnet_ids.all.ids, 0)

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 10
    },
  ]
}

module "module_count_2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name          = "module_count_"
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.nano"
  subnet_id     = element(data.aws_subnet_ids.all.ids, 0)

}

#########

resource "aws_instance" "small_no_count" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.small"
}

resource "aws_instance" "nano_count_2" {
  count = 2

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.nano"
  subnet_id     = element(data.aws_subnet_ids.all.ids, 0)
}

##########

resource "aws_instance" "small_for_each_fixed" {
  for_each = { key1 : "value1", key2 : "value2" }

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.small"
  subnet_id     = element(data.aws_subnet_ids.all.ids, 0)

  tags = { Name : each.value }
}
