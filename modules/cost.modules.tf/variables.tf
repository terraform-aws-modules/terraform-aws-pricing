variable "enabled" {
  description = "Whether to enable this module and call cost.modules.tf"
  type        = bool
  default     = true
}

variable "content" {
  description = "Content of tfstate or plan file as json"
  type        = string
}

variable "filename_hash" {
  description = "Extra hash to add to created filenames"
  type        = string
  default     = ""
}

variable "tmp_dir" {
  description = "Name of local temp directory to create files in"
  type        = string
  default     = "tmp"
}
