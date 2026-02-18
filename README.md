# harness-default-images-manual-update

a harness pipeline for manually managing default pipeline images

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
| api\_key\_harness\_secret\_id | Harness Secret ID for API Key | `string` | n/a | yes |
| org\_id | Organization ID | `string` | n/a | yes |
| project\_id | Project ID | `string` | n/a | yes |
| tags | Tags for the pipeline | `map(string)` | <pre>{<br/>  "source": "terraform"<br/>}</pre> | no |

## Outputs

No outputs.