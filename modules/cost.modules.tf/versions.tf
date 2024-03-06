terraform {
  required_version = ">= 1.0"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = ">= 2.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">= 1.0"
    }
  }
}
