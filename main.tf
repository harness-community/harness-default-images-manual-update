terraform {
  required_providers {
    harness = {
      source = "harness/harness"
    }
  }
}

data "harness_platform_current_account" "current" {}

# get default images for each module
data "http" "default" {
  for_each = toset(var.modules)

  url = "${data.harness_platform_current_account.current.endpoint}/${each.key}/execution-config/get-default-config?accountIdentifier=${data.harness_platform_current_account.current.id}&infra=k8"

  request_headers = {
    Accept      = "application/json"
    "x-api-key" = var.api_key
  }
}

resource "local_file" "default" {
  for_each = toset(var.modules)

  content  = jsonencode(jsondecode(data.http.default[each.key].response_body).data)
  filename = "${path.module}/${each.key}_${formatdate("YYYY-MMM-DD", timestamp())}.json"
}

data "http" "set_default" {
  for_each = toset(var.modules)

  url    = "${data.harness_platform_current_account.current.endpoint}/${each.key}/execution-config/update-config?accountIdentifier=${data.harness_platform_current_account.current.id}&infra=k8"
  method = "POST"

  request_headers = {
    Content-Type = "application/json"
    "x-api-key"  = var.api_key
  }

  request_body = resource.local_file.default[each.key].content
}