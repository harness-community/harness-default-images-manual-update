# manual

the following is an example of manually setting default images using terraform for each image

you should first retrive the current default images using the data source, then update them as needed

get the defaults with a simple `tofu apply`

```
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

default_images = tomap({
  "addonTag" = "harness/ci-addon:1.18.22"
  "addonTagRootless" = "harness/ci-addon:rootless-1.18.22"
```

once you upload the given images to your internal registry, you can update the default images using the resource block

```hcl
resource "harness_platform_default_images" "ci_lite_engine" {
  kind  = var.module
  field = "liteEngineTag"
  value = "harness/ci-lite-engine:1.16.5"
}
```

do this for all the default images you want to update
