variable "org_id" {
  type        = string
  description = "Organization ID"
}

variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "api_key_harness_secret_id" {
  type        = string
  description = "Harness Secret ID for API Key"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the pipeline"
  default = {
    "source" = "terraform"
  }
}

variable "modules" {
  type        = list(string)
  description = "Modules to create pipelines for"
  default     = ["ci", "idp", "iacm"]
}

variable "exclude_images" {
  type        = list(string)
  description = "Images to exclude from the pipeline"
  default     = ["iacmAnsible", "iacmAwsCdk", "iacmCheckov", "iacmModuleTest", "iacmOpenTofu", "iacmTFCompliance", "iacmTFLint", "iacmTFSec", "iacmTerraform", "iacmTerragrunt"]
}