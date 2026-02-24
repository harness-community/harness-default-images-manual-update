# harness-default-images-manual-update

a harness pipeline for manually managing default pipeline images

the terraform will load in the latest default images and tags, allowing quick modification (adding internal domain or tags)

you should leverage inputsets to save your modifications for future use

to reset everything back to default, simply set `reset` to `true`

<img width="1900" height="1812" alt="image" src="https://github.com/user-attachments/assets/078c5c3b-2206-4680-a053-fafd162cbe0d" />

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| harness | 0.41.3 |
| http | 3.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [harness_platform_pipeline.default_images_manual_update](https://registry.terraform.io/providers/harness/harness/latest/docs/resources/platform_pipeline) | resource |
| [harness_platform_current_account.current](https://registry.terraform.io/providers/harness/harness/latest/docs/data-sources/platform_current_account) | data source |
| [http_http.default](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_key | Harness API Key | `string` | n/a | yes |
| api\_key\_harness\_secret\_id | Harness Secret ID for API Key | `string` | n/a | yes |
| exclude\_images | Images to exclude from the pipeline | `list(string)` | <pre>[<br/>  "iacmAnsible",<br/>  "iacmAwsCdk",<br/>  "iacmCheckov",<br/>  "iacmModuleTest",<br/>  "iacmOpenTofu",<br/>  "iacmTFCompliance",<br/>  "iacmTFLint",<br/>  "iacmTFSec",<br/>  "iacmTerraform",<br/>  "iacmTerragrunt"<br/>]</pre> | no |
| modules | Modules to create pipelines for | `list(string)` | <pre>[<br/>  "ci",<br/>  "idp",<br/>  "iacm-manager"<br/>]</pre> | no |
| org\_id | Organization ID | `string` | n/a | yes |
| project\_id | Project ID | `string` | n/a | yes |
| tags | Tags for the pipeline | `map(string)` | <pre>{<br/>  "source": "terraform"<br/>}</pre> | no |

## Outputs

No outputs.