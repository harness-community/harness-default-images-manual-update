terraform {
  required_providers {
    harness = {
      source = "harness/harness"
    }
  }
}

variable "module" {
  type    = string
  default = "ci"
}

data "harness_platform_default_images" "customer" {
  kind = var.module
  type = "customer"
}

output "default_images" {
  value = data.harness_platform_default_images.customer.images
}

# resource "harness_platform_default_images" "ci_lite_engine" {
#   kind  = var.module
#   field = "liteEngineTag"
#   value = "harness/ci-lite-engine:1.16.5"
# }

