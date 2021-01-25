locals {
  # Filters
  aws_cli_filters = {
    for k, v in local.pricing_product_filters :
    k => join(" ", [
      for f_k, f_v in v.filters : format("Type=TERM_MATCH,Field=%s,Value=\"%s\"", f_k, f_v == null ? "null" : f_v)
    ])
  }

  aws_cli_commands = {
    for k, v in local.pricing_product_filters :
    k => <<EOF

${format("aws pricing get-products --region us-east-1 --format-version aws_v1 --service-code %s --filters %s", v.service_code, local.aws_cli_filters[k])}
EOF
  }
}
