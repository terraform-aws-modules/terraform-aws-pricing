#!/usr/bin/env bash

# Run all AWS CLI commands and verify that 1 result is returned
# Make sure to run: terraform apply (with `local.debug_output = true` to populate aws_cli_commands)

set +e # do not exit on bad exit code

aws_cli_commands=$(terraform output -json aws_cli_commands | jq -r '.[] | gsub("[\\n\\t]"; "")')

while IFS=$'\n' read -ra commands; do
  for one in "${commands[@]}"; do
    printf '%*s\n' 58 | tr ' ' '-'
    echo $one
    result=$(/bin/bash -c "$one")
    exit_code=$?

    if [ $exit_code -ne 0 ]; then
      echo "Error!"
      continue
    fi

    products=$(echo $result | jq -r '.PriceList | length')

    if [ $products -eq 0 ]; then
      echo "0 products found. Expected 1!"
    elif [ $products -ne 1 ]; then
      echo "$products products found. Expected 1!"
      echo $result | jq -r '.PriceList[0] | fromjson | .product'
      echo $result | jq -r '.PriceList[1] | fromjson | .product'
    else
      echo "OK!"
      echo $result | jq -r '.PriceList[0] | fromjson | .terms.OnDemand[].priceDimensions[].pricePerUnit.USD'
      echo $result | jq -r '.PriceList[0] | fromjson | .product'
    fi

  done
done <<< "$aws_cli_commands"

