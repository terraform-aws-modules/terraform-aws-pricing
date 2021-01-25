locals {
  # Include all attributes to keep as filters
  resource_types = { # resource's type => input's keys + transformers => save in key "filter"

    aws_instance = {
      arn = {
        transformer = "get_region_from_arn"
        filter      = "location"
      }
      instance_type = {
        filter = "instanceType"
      }
      tenancy = {
        transformer = "get_instance_tenancy"
      }

      ebs_block_device = [{
        new_resource_type = "aws_ebs_volume"
        map_values = {
          size = "volume_size"
          type = "volume_type"
        }
        }, {
        required_field    = "iops"
        new_resource_type = "_aws_ebs_provisioned_iops"
        map_values = {
          type      = "volume_type"
          _quantity = "iops"
        }
      }]

      root_block_device = [{
        new_resource_type = "aws_ebs_volume"
        map_values = {
          size = "volume_size"
          type = "volume_type"
        }
        }, {
        required_field    = "iops"
        new_resource_type = "_aws_ebs_provisioned_iops"
        map_values = {
          type      = "volume_type"
          _quantity = "iops"
        }
      }]
    }


    aws_ebs_volume = {
      availability_zone = {
        transformer = "get_region_from_availability_zone"
        filter      = "location"
      }
      type = {
        filter = "volumeApiName"
      }
      size = {
        filter = "_quantity"
      }

      # Note: Type of the value here should be `list(map)`, one or several subfilters will be created.
      iops = [{
        required_field    = "iops"
        new_resource_type = "_aws_ebs_provisioned_iops"
        map_values = {
          type      = "type"
          _quantity = "iops"
        }
      }]

    }

    aws_ebs_snapshot = {
      arn = {
        transformer = "get_region_from_arn_with_lookup_ebs_snapshot_usagetype"
        filter      = "usagetype"
      }
      volume_size = {
        filter = "_quantity"
      }
    }

    aws_ebs_snapshot_copy = {
      arn = {
        transformer = "get_region_from_arn_with_lookup_ebs_snapshot_usagetype"
        filter      = "usagetype"
      }
      volume_size = {
        filter = "_quantity"
      }
    }

    aws_lb = {
      arn = {
        transformer = "get_region_from_arn_with_lookup_lb_usagetype"
        filter      = "usagetype"
      }
      load_balancer_type = {
        transformer = "get_load_balancer_type"
        filter      = "productFamily"
      }
    }

    aws_alb = {
      arn = {
        transformer = "get_region_from_arn_with_lookup_lb_usagetype"
        filter      = "usagetype"
      }
      load_balancer_type = {
        transformer = "get_load_balancer_type"
        filter      = "productFamily"
      }
    }

    aws_elb = {
      arn = {
        transformer = "get_region_from_arn_with_lookup_lb_usagetype"
        filter      = "usagetype"
      }
    }

    aws_nat_gateway = {}

    aws_redshift_cluster = {
      node_type = {
        filter = "instanceType"
      }
      number_of_nodes = {
        filter = "_quantity"
      }
    }

    aws_db_instance = {
      instance_class = {
        filter = "instanceType"
      }
      multi_az = {
        transformer = "get_multi_az"
        filter      = "deploymentOption"
      }
      engine = {
        transformer = "get_db_instance_engine"
        filter      = "databaseEngine"
      }
      # Note: Key (eg, deletion_protection) should exist in resource but not used in other filters
      deletion_protection = {
        transformer = "get_db_instance_engine_edition"
        filter      = "databaseEdition"
      }

    }

    ##########################################
    # Custom types (produced from main types)
    ##########################################
    _aws_ebs_provisioned_iops = {}

  }

  # Map with default filters for each resource type (it will be merged with the data provided)
  resource_defaults = {
    aws_instance = {
      location        = var.aws_default_region
      operatingSystem = "Linux"
      preInstalledSw  = "NA"
      licenseModel    = "No License required"
      tenancy         = "Shared"
      capacitystatus  = "Used"
    }

    aws_ebs_volume = {
      location      = var.aws_default_region
      productFamily = "Storage"
      volumeApiName = var.aws_default_ebs_volume_type
      _quantity     = var.aws_default_ebs_volume_size
      _divisor      = 730 # Storage has unit GB-Mo, so converting to price per hour
    }

    _aws_ebs_provisioned_iops = {
      location      = var.aws_default_region
      productFamily = "System Operation"
      group         = "EBS IOPS"
      volumeApiName = "gp3"
      _quantity     = var.aws_default_ebs_volume_size
      _divisor      = 730 # PIOPS has unit IOPS-month, so converting to price per hour
    }

    #    _aws_ebs_provisioned_storage = { # @todo
    #      location      = var.aws_default_region
    #      productFamily = "System Operation"
    #      volumeApiName = "gp3"
    #      _quantity     = var.aws_default_ebs_volume_size
    #      _divisor      = 730 # Storage has unit GB-Mo, so converting to price per hour
    #    }

    aws_ebs_snapshot = {
      location      = var.aws_default_region
      productFamily = "Storage Snapshot"
      usagetype     = lookup(local.ebs_snapshot_usagetype, var.aws_default_region, "EBS:SnapshotUsage")
      _quantity     = var.aws_default_ebs_volume_size
      _divisor      = 730 # Storage has unit GB-Mo, so converting to price per hour
    }

    aws_ebs_snapshot_copy = {
      location      = var.aws_default_region
      productFamily = "Storage Snapshot"
      usagetype     = lookup(local.ebs_snapshot_usagetype, var.aws_default_region, "EBS:SnapshotUsage")
      _quantity     = var.aws_default_ebs_volume_size
      _divisor      = 730 # Storage has unit GB-Mo, so converting to price per hour
    }

    aws_lb = {
      usagetype = lookup(local.lb_usagetype, var.aws_default_region, "LoadBalancerUsage")
    }

    aws_alb = {
      usagetype = lookup(local.lb_usagetype, var.aws_default_region, "LoadBalancerUsage")
    }

    aws_elb = {
      productFamily = "Load Balancer"
      usagetype     = lookup(local.lb_usagetype, var.aws_default_region, "LoadBalancerUsage")
    }

    aws_nat_gateway = {
      productFamily = "NAT Gateway"
      usagetype     = lookup(local.nat_gateway_usagetype, var.aws_default_region, "NatGateway-Hours")
    }

    aws_redshift_cluster = {
      location      = var.aws_default_region
      productFamily = "Compute Instance"
      termType      = "OnDemand"
    }

    aws_db_instance = {
      location         = var.aws_default_region
      productFamily    = "Database Instance"
      termType         = "OnDemand"
      deploymentOption = "Single-AZ"
    }
  }

  # Map with supported AWS resources
  resources_service_code = {
    aws_instance          = "AmazonEC2"
    aws_ebs_volume        = "AmazonEC2"
    aws_ebs_snapshot      = "AmazonEC2"
    aws_ebs_snapshot_copy = "AmazonEC2"
    aws_ebs_snapshot_copy = "AmazonEC2"
    aws_lb                = "AmazonEC2"
    aws_alb               = "AmazonEC2"
    aws_elb               = "AmazonEC2"
    aws_nat_gateway       = "AmazonEC2"
    aws_redshift_cluster  = "AmazonRedshift"
    aws_db_instance       = "AmazonRDS"

    # Custom types
    _aws_ebs_provisioned_iops = "AmazonEC2"
  }


  #################################################
  # NAT Gateway has "usagetype" filter per region
  #################################################
  nat_gateway_usagetype = {
    us-east-1      = "NatGateway-Hours" # default
    us-east-2      = "USE2-NatGateway-Hours"
    us-west-1      = "USW1-NatGateway-Hours"
    us-west-2      = "USW2-NatGateway-Hours"
    af-south-1     = "AFS1-NatGateway-Hours"
    ap-east-1      = "APE1-NatGateway-Hours"
    ap-south-1     = "APS1-NatGateway-Hours"
    ap-northeast-1 = "APN1-NatGateway-Hours"
    ap-northeast-2 = "APN2-NatGateway-Hours"
    ap-northeast-3 = "APN3-NatGateway-Hours"
    ap-southeast-1 = "APS1-NatGateway-Hours"
    ap-southeast-2 = "APS2-NatGateway-Hours"
    ca-central-1   = "CAN1-NatGateway-Hours"
    eu-central-1   = "EUC1-NatGateway-Hours"
    eu-west-1      = "EU-NatGateway-Hours"
    eu-west-2      = "EUW2-NatGateway-Hours"
    eu-west-3      = "EUW3-NatGateway-Hours"
    eu-south-1     = "EUS1-NatGateway-Hours"
    eu-north-1     = "EUN1-NatGateway-Hours"
    me-south-1     = "MES1-NatGateway-Hours"
    sa-east-1      = "SAE1-NatGateway-Hours"
    us-gov-west-1  = "UGW1-NatGateway-Hours"
    us-gov-east-1  = "UGE1-NatGateway-Hours"
  }

  #################################################
  # ELB/ALB/NLB has "usagetype" filter per region
  #################################################
  lb_usagetype = {
    us-east-1      = "LoadBalancerUsage" # default
    us-east-2      = "USE2-LoadBalancerUsage"
    us-west-1      = "USW1-LoadBalancerUsage"
    us-west-2      = "USW2-LoadBalancerUsage"
    af-south-1     = "AFS1-LoadBalancerUsage"
    ap-east-1      = "APE1-LoadBalancerUsage"
    ap-south-1     = "APS1-LoadBalancerUsage"
    ap-northeast-1 = "APN1-LoadBalancerUsage"
    ap-northeast-2 = "APN2-LoadBalancerUsage"
    ap-northeast-3 = "APN3-LoadBalancerUsage"
    ap-southeast-1 = "APS1-LoadBalancerUsage"
    ap-southeast-2 = "APS2-LoadBalancerUsage"
    ca-central-1   = "CAN1-LoadBalancerUsage"
    eu-central-1   = "EUC1-LoadBalancerUsage"
    eu-west-1      = "EU-LoadBalancerUsage"
    eu-west-2      = "EUW2-LoadBalancerUsage"
    eu-west-3      = "EUW3-LoadBalancerUsage"
    eu-south-1     = "EUS1-LoadBalancerUsage"
    eu-north-1     = "EUN1-LoadBalancerUsage"
    me-south-1     = "MES1-LoadBalancerUsage"
    sa-east-1      = "SAE1-LoadBalancerUsage"
    us-gov-west-1  = "UGW1-LoadBalancerUsage"
    us-gov-east-1  = "UGE1-LoadBalancerUsage"
  }

  #################################################
  # EBS Snapshot has "usagetype" filter per region
  #################################################
  ebs_snapshot_usagetype = {
    us-east-1      = "EBS:SnapshotUsage" # default
    us-east-2      = "USE2-EBS:SnapshotUsage"
    us-west-1      = "USW1-EBS:SnapshotUsage"
    us-west-2      = "USW2-EBS:SnapshotUsage"
    af-south-1     = "AFS1-EBS:SnapshotUsage"
    ap-east-1      = "APE1-EBS:SnapshotUsage"
    ap-south-1     = "APS1-EBS:SnapshotUsage"
    ap-northeast-1 = "APN1-EBS:SnapshotUsage"
    ap-northeast-2 = "APN2-EBS:SnapshotUsage"
    ap-northeast-3 = "APN3-EBS:SnapshotUsage"
    ap-southeast-1 = "APS1-EBS:SnapshotUsage"
    ap-southeast-2 = "APS2-EBS:SnapshotUsage"
    ca-central-1   = "CAN1-EBS:SnapshotUsage"
    eu-central-1   = "EUC1-EBS:SnapshotUsage"
    eu-west-1      = "EU-EBS:SnapshotUsage"
    eu-west-2      = "EUW2-EBS:SnapshotUsage"
    eu-west-3      = "EUW3-EBS:SnapshotUsage"
    eu-south-1     = "EUS1-EBS:SnapshotUsage"
    eu-north-1     = "EUN1-EBS:SnapshotUsage"
    me-south-1     = "MES1-EBS:SnapshotUsage"
    sa-east-1      = "SAE1-EBS:SnapshotUsage"
    us-gov-west-1  = "UGW1-EBS:SnapshotUsage"
    us-gov-east-1  = "UGE1-EBS:SnapshotUsage"
  }

  ################
  # RDS DB Engine
  # https://docs.aws.amazon.com/cli/latest/reference/rds/describe-db-engine-versions.html#options
  # aws pricing get-attribute-values --region us-east-1 --service-code AmazonRDS --attribute-name databaseEngine
  ################
  db_instance_engine = {
    mysql         = "MySQL"
    postgres      = "PostgreSQL"
    oracle-ee     = "Oracle"
    oracle-se     = "Oracle"
    oracle-se1    = "Oracle"
    oracle-se2    = "Oracle"
    mariadb       = "MariaDB"
    sqlserver-ex  = "SQL Server"
    sqlserver-ee  = "SQL Server"
    sqlserver-se  = "SQL Server"
    sqlserver-web = "SQL Server"

    aurora            = "Aurora MySQL"
    aurora-mysql      = "Aurora MySQL"
    aurora-postgresql = "Aurora PostgreSQL"
  }

  # aws pricing get-attribute-values --region us-east-1 --service-code AmazonRDS --attribute-name databaseEdition
  db_instance_engine_edition = {
    oracle-ee     = "Enterprise"
    oracle-se     = "Standard"
    oracle-se1    = "Standard One"
    oracle-se2    = "Standard Two"
    sqlserver-ee  = "Enterprise"
    sqlserver-ex  = "Express"
    sqlserver-se  = "Standard"
    sqlserver-web = "Web"
  }

}
