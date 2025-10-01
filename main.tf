resource "random_id" "bucket_kms_key_id" {
  byte_length = 4
}

resource "opentelekomcloud_kms_key_v1" "bucket_kms_key" {
  key_alias       = "${var.bucket_name}-key-${random_id.bucket_kms_key_id.hex}"
  key_description = "${var.bucket_name} encryption key"
  pending_days    = 7
  is_enabled      = "true"
  tags            = var.tags

}

resource "opentelekomcloud_obs_bucket" "bucket" {
  bucket        = var.bucket_name
  acl           = "private"
  versioning    = var.enable_versioning
  force_destroy = var.force_destroy
  server_side_encryption {
    algorithm  = "kms"
    kms_key_id = opentelekomcloud_kms_key_v1.bucket_kms_key.id
  }
  tags = var.tags

  dynamic "worm_policy" {
    for_each = var.enable_worm_policy ? [1] : []
    content {
      years = var.worm_policy_years
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      name    = lifecycle_rule.value.name
      enabled = lifecycle_rule.value.enabled
      prefix  = lifecycle_rule.value.prefix

      dynamic "tag" {
        for_each = lifecycle_rule.value.tags != null ? lifecycle_rule.value.tags : []
        content {
          key   = tag.value.key
          value = tag.value.value
        }
      }

      dynamic "expiration" {
        for_each = lifecycle_rule.value.expiration != null ? [lifecycle_rule.value.expiration] : []
        content {
          days = expiration.value.days
        }
      }

      dynamic "transition" {
        for_each = lifecycle_rule.value.transitions != null ? lifecycle_rule.value.transitions : []
        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lifecycle_rule.value.noncurrent_version_expiration != null ? [lifecycle_rule.value.noncurrent_version_expiration] : []
        content {
          days = noncurrent_version_expiration.value.days
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = lifecycle_rule.value.noncurrent_version_transitions != null ? lifecycle_rule.value.noncurrent_version_transitions : []
        content {
          days          = noncurrent_version_transition.value.days
          storage_class = noncurrent_version_transition.value.storage_class
        }
      }

      dynamic "abort_incomplete_multipart_upload" {
        for_each = lifecycle_rule.value.abort_incomplete_multipart_upload != null ? [lifecycle_rule.value.abort_incomplete_multipart_upload] : []
        content {
          days = abort_incomplete_multipart_upload.value.days
        }
      }
    }
  }
}

