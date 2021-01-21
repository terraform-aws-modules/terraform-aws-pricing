locals {
  filename      = format("%s/file_%s.json", var.tmp_dir, md5(format("%s%s", var.content, var.filename_hash)))
  cost_filename = format("%s/cost_%s.json", var.tmp_dir, md5(format("%s%s", var.content, var.filename_hash)))
}

resource "local_file" "json_input" {
  count = var.enabled ? 1 : 0

  filename = local.filename
  content  = var.content
}

resource "null_resource" "curl" {
  count = var.enabled ? 1 : 0

  triggers = {
    file = local_file.json_input[0].filename
  }

  provisioner "local-exec" {
    command = format("curl -s -X POST -H \"Content-Type: application/json\" -d @%s -o %s https://cost.modules.tf/", local_file.json_input[0].filename, local.cost_filename)
  }
}

data "null_data_source" "costs" {
  count = var.enabled ? 1 : 0

  inputs = {
    id            = null_resource.curl[0].id
    cost_filename = local.cost_filename
  }
}
