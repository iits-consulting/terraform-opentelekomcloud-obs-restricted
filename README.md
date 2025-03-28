## Restricted OBS Bucket

This modules creates an OBS Bucket with KMS SSE default encryption and user that able to access to it.

> **Note**  
> Please remember that OBS and KMS work only on top level projects (eu-de or eu-nl) !!!

### Usage example

```hcl
provider "opentelekomcloud" {
  alias       = "top_level_project"
  max_retries = 100
  auth_url    = "https://iam.eu-de.otc.t-systems.com/v3"
  tenant_name = "eu-de"
  region      = "eu-de"
}

module "obs_restricted_eu_de" {
  source      = "iits-consulting/obs_restricted/opentelekomcloud"

  bucket_name = var.bucket_name
  providers = {
    opentelekomcloud = opentelekomcloud.top_level_project
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_errorcheck"></a> [errorcheck](#requirement\_errorcheck) | 3.0.3 |
| <a name="requirement_opentelekomcloud"></a> [opentelekomcloud](#requirement\_opentelekomcloud) | ~> 1.35 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_errorcheck"></a> [errorcheck](#provider\_errorcheck) | 3.0.3 |
| <a name="provider_opentelekomcloud"></a> [opentelekomcloud](#provider\_opentelekomcloud) | ~> 1.35 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [errorcheck_is_valid.provider_project_constraint](https://registry.terraform.io/providers/iits-consulting/errorcheck/3.0.3/docs/resources/is_valid) | resource |
| [opentelekomcloud_identity_credential_v3.user_aksk](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/resources/identity_credential_v3) | resource |
| [opentelekomcloud_identity_group_membership_v3.user_to_obsgroup](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/resources/identity_group_membership_v3) | resource |
| [opentelekomcloud_identity_group_v3.obs_group](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/resources/identity_group_v3) | resource |
| [opentelekomcloud_identity_role_assignment_v3.kms_adm_to_obs_group](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/resources/identity_role_assignment_v3) | resource |
| [opentelekomcloud_identity_role_assignment_v3.obs_role_to_obs_group](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/resources/identity_role_assignment_v3) | resource |
| [opentelekomcloud_identity_role_v3.bucket_access](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/resources/identity_role_v3) | resource |
| [opentelekomcloud_identity_role_v3.kms_access](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/resources/identity_role_v3) | resource |
| [opentelekomcloud_identity_user_v3.user](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/resources/identity_user_v3) | resource |
| [opentelekomcloud_kms_key_v1.bucket_kms_key](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/resources/kms_key_v1) | resource |
| [opentelekomcloud_obs_bucket.bucket](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/resources/obs_bucket) | resource |
| [random_id.bucket_kms_key_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [opentelekomcloud_identity_project_v3.current](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/data-sources/identity_project_v3) | data source |
| [opentelekomcloud_identity_project_v3.obs_project](https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/latest/docs/data-sources/identity_project_v3) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Bucket name. Make sure the provider for this module has tennant\_name=<region> set | `string` | n/a | yes |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Disable the versioning for the bucket. Default: true | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Destroy all objects from the bucket so that the bucket can be destroyed without error. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_access_key"></a> [bucket\_access\_key](#output\_bucket\_access\_key) | OBS bucket access key for the created user. Can only access to the specific bucket and the specific KMS key used for bucket encryption. |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | OBS bucket name passthrough with dependency chain. |
| <a name="output_bucket_secret_key"></a> [bucket\_secret\_key](#output\_bucket\_secret\_key) | OBS bucket secret key for the created user. Can only access to the specific bucket and the specific KMS key used for bucket encryption. |
<!-- END_TF_DOCS -->
