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
  url      = "${data.harness_platform_current_account.current.endpoint}/${each.key}/execution-config/get-default-config?accountIdentifier=${data.harness_platform_current_account.current.id}&infra=k8"

  request_headers = {
    Accept      = "application/json"
    "x-api-key" = var.api_key
  }
}

locals {
  default_images = { for module in var.modules : module => {
    for k, v in jsondecode(data.http.default[module].response_body).data : k => v
    if !contains(var.exclude_images, k)
  } }
}

# create pipeline for each module
resource "harness_platform_pipeline" "default_images_manual_update" {
  for_each = toset(var.modules)

  org_id     = var.org_id
  project_id = var.project_id

  identifier  = replace("${each.key}_default_images_manual_update", "-", "_")
  name        = "${upper(each.key)} Default Images Manual Update"
  description = "Manually set default images for ${upper(each.key)}"
  tags        = [for k, v in var.tags : "${k}:${v}"]

  yaml = templatefile(
    "${path.module}/templates/pipeline.tpml",
    {
      # Pipeline Setup Details
      PIPELINE_IDENTIFIER : replace("${each.key}_default_images_manual_update", "-", "_")
      PIPELINE_NAME : "${upper(each.key)} Default Images Manual Update"
      ORGANIZATION_ID : var.org_id
      PROJECT_ID : var.project_id
      DESCRIPTION : "Manually set default images for ${upper(each.key)}"

      # Pipeline Inputs
      SECRET_ID : var.api_key_harness_secret_id
      MODULE : each.key
      DEFAULT_IMAGES : local.default_images[each.key]
      SET_IMAGES : jsonencode([for image, value in local.default_images[each.key] : { "field" : image, "value" : value }])
      RESET_IMAGES : jsonencode([for image, _ in local.default_images[each.key] : { "field" : image }])

      TAGS : yamlencode(var.tags)
    }
  )
}
