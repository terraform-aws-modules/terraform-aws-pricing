# Inputs
variable "resources" {
  description = "Map of all resources to calculate price for"
  type        = any
  default     = {}
}

variable "content" {
  description = "JSON object containing data of Terraform plan or state"
  type        = any
  default     = {}
}

# Debug
variable "call_aws_pricing_api" {
  description = "Whether to call AWS Pricing API for real or just output filter (it is useful to disable this to see filters instead of calling API)"
  type        = bool
  default     = true
}

variable "debug_output" {
  description = "Whether to populate more output (useful for debug, but increase verbosity and size of tfstate)"
  type        = bool
  default     = false
}

# Defaults
variable "aws_default_region" {
  description = "Default AWS region to use for resources (if not set) when asking AWS Pricing API"
  type        = string
  default     = "us-east-1"
}
