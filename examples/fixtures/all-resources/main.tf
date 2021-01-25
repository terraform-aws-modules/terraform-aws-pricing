provider "aws" {
  region = "eu-west-1"
}

#######################################################
# aws_instance
# aws_autoscaling_group + aws_launch_configuration + aws_launch_template + spot
# aws_ec2_fleet
#######################################################

resource "aws_instance" "i1" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.small"
}

resource "aws_instance" "i2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "c5.large"
  tenancy       = "dedicated"
}

resource "aws_instance" "i3" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "c5.xlarge"
  tenancy       = "dedicated"

  ebs_block_device { # "standard", "gp2", "io1", "sc1", or "st1". (Default: "gp2").
    device_name = "xvfa"
    volume_size = 10
  }

  ebs_block_device {
    device_name = "xvfb"
    volume_size = 20
    volume_type = "sc1"
  }

  ebs_block_device {
    device_name = "xvfc"
    volume_size = 30
    volume_type = "st1"
  }

  ebs_block_device {
    device_name = "xvfd"
    volume_size = 40
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name = "xvfe"
    volume_size = 40
    volume_type = "gp3"
    iops        = 100
  }

  ebs_block_device {
    device_name = "xvfe"
    volume_size = 50
    volume_type = "io1"
    iops        = 2000
  }

  root_block_device {
    volume_type = "io1" # "standard", "gp2", "io1", "sc1", or "st1". (Default: "standard").
    iops        = 220
  }
}
/*
data "aws_launch_template" "test_lt" {
  name = "test-lt"
}

resource "aws_autoscaling_group" "with_lt1" {
  desired_capacity   = 1
  max_size           = 2
  min_size           = 0

  vpc_zone_identifier = tolist(data.aws_subnet_ids.all.ids)

  launch_template {
    id = aws_launch_template.this_lt_spot1.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "with_lt2" {
  desired_capacity   = 0
  max_size           = 1
  min_size           = 0

  vpc_zone_identifier = tolist(data.aws_subnet_ids.all.ids)

  launch_template {
    id      = aws_launch_template.this_lt2.id
    version = "$Latest"
  }
}

resource "aws_launch_template" "this_lt_spot1" {
  image_id = data.aws_ami.amazon_linux.id
  instance_type = "t2.nano"

  instance_market_options {
    market_type = "spot"
  }

  elastic_gpu_specifications {
    type = "eg1.medium"
  }

  elastic_gpu_specifications {
    type = "eg1.large"
  }

  elastic_inference_accelerator { # this is not part of EC2 pricing
    type = "eia1.medium"
  }
}

resource "aws_launch_template" "this_lt1" {
  image_id = data.aws_ami.amazon_linux.id
  instance_type = "t2.nano"

  elastic_gpu_specifications {
    type = "eg1.medium"
  }

  elastic_gpu_specifications {
    type = "eg1.large"
  }

  elastic_inference_accelerator { # this is not part of EC2 pricing
    type = "eia1.medium"
  }
}

resource "aws_launch_template" "this_lt2" {
  image_id = data.aws_ami.amazon_linux.id
  instance_type = "t2.nano"
}
*/
# resource "aws_ec2_fleet" "example" {
#   launch_template_config {
#     launch_template_specification {
#       launch_template_id = aws_launch_template.fleet_lt_notspot.id
#       version            = aws_launch_template.fleet_lt_notspot.latest_version
#     }
#   }
#
#   target_capacity_specification {
#     default_target_capacity_type = "on-demand"
#     total_target_capacity        = 1
#   }
# }

#######################################################
# aws_ebs_volume
# aws_ebs_snapshot
# aws_ebs_snapshot_copy
#######################################################

resource "aws_ebs_volume" "v1" {
  availability_zone = "eu-west-1a"
  size              = 10
}

resource "aws_ebs_volume" "v2" {
  availability_zone = "eu-west-1a"
  snapshot_id       = "snapshot-123456"
}

resource "aws_ebs_volume" "v3" {
  availability_zone = "eu-west-1a"
  type              = "sc1"
  size              = 30
}

resource "aws_ebs_volume" "v4" {
  availability_zone = "eu-west-1a"
  type              = "io2"
  iops              = 100
  size              = 50
}

resource "aws_ebs_volume" "v5" {
  availability_zone = "eu-west-1a"
  type              = "gp3"
  size              = 20
}

resource "aws_ebs_volume" "v6" {
  availability_zone = "eu-west-1a"
  type              = "gp2"
  size              = 50
}

resource "aws_ebs_volume" "v7" {
  availability_zone = "eu-west-1a"
  type              = "io1"
  iops              = 150
  size              = 100
}

resource "aws_ebs_volume" "v8" {
  availability_zone = "eu-west-1a"
  type              = "st1"
  size              = 100
}

resource "aws_ebs_snapshot" "s1" {
  volume_id = aws_ebs_volume.v4.id
}

resource "aws_ebs_snapshot_copy" "sc1" {
  source_region      = "eu-west-1"
  source_snapshot_id = aws_ebs_snapshot.s1.id
}

#######################################################
# aws_lb / aws_alb
# aws_elb
# aws_nat_gateway
#######################################################

resource "aws_elb" "elb" {
  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  subnets = data.aws_subnet_ids.all.ids
}

resource "aws_lb" "alb1" {
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.all.ids
}

resource "aws_alb" "alb2" {
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.all.ids
}

resource "aws_lb" "nlb" {
  load_balancer_type = "network"
  subnets            = data.aws_subnet_ids.all.ids
}

resource "aws_lb" "undefined_type" {
  subnets = data.aws_subnet_ids.all.ids
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = tolist(data.aws_subnet_ids.all.ids)[0]
}

#######################################################
# aws_redshift_cluster
#######################################################

resource "aws_redshift_cluster" "r1" {
  cluster_identifier = "redshift-cluster1"
  node_type          = "dc2.large"
}

resource "aws_redshift_cluster" "r2" {
  cluster_identifier = "redshift-cluster2"
  node_type          = "ds2.8xlarge"
  number_of_nodes    = 3
}

#######################################################
# aws_db_instance
#######################################################

# databaseEngine = "MySQL"
resource "aws_db_instance" "d1" {
  engine         = "mysql"
  instance_class = "db.t3.large"
}

resource "aws_db_instance" "d2" {
  engine            = "mysql"
  instance_class    = "db.t3.small"
  allocated_storage = 20
  storage_type      = "io1"
  iops              = 230
}

# databaseEngine = "PostgreSQL"
resource "aws_db_instance" "d3" {
  engine            = "postgres"
  instance_class    = "db.t3.small"
  allocated_storage = 10
  storage_type      = "gp2"
}

resource "aws_db_instance" "d4" {
  engine            = "postgres"
  instance_class    = "db.t3.small"
  allocated_storage = 10
  storage_type      = "gp2"
  multi_az          = true
}

# databaseEngine = "SQL Server"
# databaseEdition = "Express"
resource "aws_db_instance" "d5" {
  engine            = "sqlserver-ex"
  instance_class    = "db.t3.medium"
  allocated_storage = 30
  storage_type      = "gp2"
}

# databaseEngine = "SQL Server"
# databaseEdition = "Enterprise"
resource "aws_db_instance" "d6" {
  engine            = "sqlserver-ee"
  instance_class    = "db.r5.xlarge"
  allocated_storage = 30
  storage_type      = "gp2"
}

# databaseEngine = "SQL Server"
# databaseEdition = "Standard"
resource "aws_db_instance" "d7" {
  engine            = "sqlserver-se"
  instance_class    = "db.r5.xlarge"
  allocated_storage = 30
  storage_type      = "gp2"
}

# databaseEngine = "SQL Server"
# databaseEdition = "Web"
resource "aws_db_instance" "d8" {
  engine            = "sqlserver-web"
  instance_class    = "db.r5.xlarge"
  allocated_storage = 30
  storage_type      = "gp2"
}

# databaseEngine = "Oracle"
resource "aws_db_instance" "d9" {
  engine            = "oracle-ee"
  instance_class    = "db.t3.large"
  allocated_storage = 40
  storage_type      = "gp2"
}

# databaseEngine = "MariaDB"
resource "aws_db_instance" "d10" {
  engine            = "mariadb"
  instance_class    = "db.t3.large"
  allocated_storage = 40
  storage_type      = "gp2"
}
