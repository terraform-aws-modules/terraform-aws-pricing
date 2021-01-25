#!/usr/bin/env sh

set -e # do exit on bad exit code

# Locate the directory in which this script is located
readonly SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd $SCRIPT_PATH

terraform init -input=false
terraform plan -out=plan.tfplan > /dev/null && terraform show -json plan.tfplan | jq -r > plan.json

# Apply to create terraform.tfstate
terraform apply plan.tfplan
