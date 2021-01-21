locals {
  # Map with supported AWS resources
  resources_service_code = {
    aws_instance = "AmazonEC2"
  }

  # Map with default filters for each resource type (it will be merged with the data provided)
  resource_defaults = {
    aws_instance = {
      operatingSystem = "Linux"
      preInstalledSw  = "NA"
      licenseModel    = "No License required"
      tenancy         = "Shared" # Options are - "Dedicated"
      capacitystatus  = "Used"
      location        = var.aws_default_region
    }
  }



  resource_types = { # type => list of attributes to keep
    aws_instance = {
      arn : { transformer : "get_region_from_arn", filter : "location" }
      instance_type : { filter : "instanceType" }
    }

    aws_ebs_volume = {
      arn : { transformer : "cut_region_from_arn", filter : "location" }
      volume_type : { filter : "volumeType" }, # @todo: check filter
      volume_size : { filter : "volumeSize" }, # @todo: check filter
      iops : { filter : "iops" },              # @todo: check filter
    }

  }
}
