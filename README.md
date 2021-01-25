# Terraform AWS pricing module

Terraform module, which calculates the AWS infrastructure cost in a variety of ways. This is not a _traditional_ Terraform module because it does not create AWS infrastructure resources but using Terraform plan and Terraform states as input.

`cost.modules.tf` is entirely free cost estimation service, which is part of [modules.tf](https://modules.tf) that is currently in active development.

Join the mailing list on [modules.tf](https://modules.tf) to stay updated!

If you are looking into alternative ways calculating AWS infrastructure costs (for free), you can use [terraform-cost-estimation.com](https://www.terraform-cost-estimation.com) or [terraform-cost-estimation](https://github.com/antonbabenko/terraform-cost-estimation).

This is not an official HashiCorp product.

## Features/goals

- [x] Calculate costs before creation:
  - [x] tfplan
- [x] Calculate costs after creation:
  - [x] tfstate
- [x] Calculate costs from multiple sources (local, remote states, specified resources)
- [x] Optionally, using [cost.modules.tf](https://cost.modules.tf/)
- [x] Can be executed on restricted CI/CD platforms where Terraform can run


## Supported resources

1. EC2 instances (on-demand) and Autoscaling Groups (Launch Configurations and Launch Templates):
- [x] aws_instance
- [ ] aws_autoscaling_group
- [ ] aws_launch_configuration
- [ ] aws_launch_template

2. EC2 Fleets (on-demand)
- [ ] aws_ec2_fleet

3. EBS Volumes, Snapshots, Snapshot Copies
- [x] aws_ebs_volume
- [x] aws_ebs_snapshot
- [x] aws_ebs_snapshot_copy

4. Elastic Load Balancing (ELB, ALB, NLB)
- [x] aws_elb
- [x] aws_alb / aws_lb

5. NAT Gateways
- [x] aws_nat_gateway

6. Redshift Clusters
- [x] aws_redshift_cluster


## Usages

### Using AWS Pricing API: Terraform state or plan as JSON

```hcl
provider "aws" {
  region = "us-east-1"
}

module "pricing" {
  source = "terraform-aws-modules/pricing/aws//modules/pricing"
  
  # content can be Terraform state or plan as JSON fetched from any source (see examples)
  content = jsondecode("{\"version\": 4, \"terraform_version\": \"0.14.4\", ...")
}
```

### Using AWS Pricing API: Terraform plan as JSON from local file

```hcl
provider "aws" {
  region = "us-east-1"
}

data "local_file" "local_plan" {
  filename = "local_plan.json"
}

module "pricing" {
  source = "terraform-aws-modules/pricing/aws//modules/pricing"
  
  content = jsondecode(data.local_file.local_plan.content)
}
```

### Using AWS Pricing API: Specified resources

```hcl
provider "aws" {
  region = "us-east-1"
}

module "pricing" {
  source = "terraform-aws-modules/pricing/aws//modules/pricing"
  
  resources = {
    "aws_instance.this#5" = { # Note: This means 5 instances (`count = 5`)
      instanceType = "c5.xlarge"
      location     = "eu-west-2"
    }
    "aws_instance.this2" = {
      instanceType = "c4.xlarge"
      location     = "eu-central-1"
    }
  }
}
```

### Run in automation

@todo: Describe in more details...

```shell
# Project1 (with real EC2 resources):
terraform plan -out=plan.tfplan > /dev/null && terraform show -json plan.tfplan > plan.json

# Project2 (terraform-aws-pricing module):
TF_VAR_file_path=plan.json terraform apply
HOURLY_PRICE=$(terraform output -raw total_price_per_hour)

if HOURLY_PRICE < 10 then
  terraform apply plan.json # (from Project1)
else
  echo "Crash! Boom! Bang!"
end
```

### Notes

#### AWS provider

Set AWS provider's region to `us-east-1` or `sa-east-1` when using [modules/pricing](https://github.com/terraform-aws-modules/terraform-aws-pricing/tree/master/modules/pricing) because AWS Pricing service is only available in these regions.

You can also pass provider explicitly as described in the [official documentation](https://www.terraform.io/docs/modules/providers.html#passing-providers-explicitly). 


#### Debug & development tips

1. `debug_output = true` will return more output which is often helpful only for development and debug purposes.

2. `call_aws_pricing_api = false` will not call AWS Pricing API. Wrong filters produce a lot of noise, so it makes sense to disable this option when developing new filters.

3. AWS Pricing API should always return one response for the filter. Running these commands can help identify available filters to put into `modules/pricing/filters.tf` (see `dev` directory also):

    > aws pricing describe-services --service-code AmazonEC2 --format-version aws_v1 --max-items 1 --region us-east-1

    > aws pricing get-products --region us-east-1 --filters file://filters.json --format-version aws_v1 --service-code AmazonEC2


#### Ephemeral Terraform backend

Sometimes, you may want to not store Terraform state in backend when dealing with pricing, you can use backend "inmem":

```hcl
terraform {
  backend "inmem" {}
}
```

When you use this type of backend, there is no way to run `terraform output`.


### Known issues/limitations

1. Autoscaling groups resources
1. When changing values price is sometimes higher after the first run because it is calculated based on keys and there can be some previous keys. Solution is to update code to include some unique key/prefix. Or just disable terraform state (no state = no past).
1. At some point later, maybe add support for other providers like [Azure](http://davecallan.com/azure-price-api-examples/) and [Google Cloud](https://stackoverflow.com/questions/59048071/how-to-get-gcp-pricing-list-from-catalogue-api)


## Examples

* [Cost estimation using cost.modules.tf service](https://github.com/terraform-aws-modules/terraform-aws-pricing/tree/master/examples/cost.modules.tf)
* [Terraform state/plan cost estimation using AWS Pricing API](https://github.com/terraform-aws-modules/terraform-aws-pricing/tree/master/examples/pricing-terraform-state-and-plan)
* [Complete example using AWS Pricing API](https://github.com/terraform-aws-modules/terraform-aws-pricing/tree/master/examples/complete) - Get cost estimation for multiple sources combined.
* [Specified resources using AWS Pricing API](https://github.com/terraform-aws-modules/terraform-aws-pricing/tree/master/examples/pricing-resources) - Get cost estimation for specified resources.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module created and managed by [Anton Babenko](https://github.com/antonbabenko).

Please reach out to [Betajob](https://www.betajob.com/) if you are looking for commercial support for your Terraform, AWS, or serverless project.


## License

Apache 2 Licensed. See LICENSE for full details.
