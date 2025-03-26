output "bucket_name" {
  value       = opentelekomcloud_obs_bucket.bucket.bucket
  description = "OBS bucket name passthrough with dependency chain."
}

output "bucket_access_key" {
  value       = opentelekomcloud_identity_credential_v3.user_aksk.access
  description = "OBS bucket access key for the created user. Can only access to the specific bucket and the specific KMS key used for bucket encryption."
  sensitive   = true
}

output "bucket_secret_key" {
  value       = opentelekomcloud_identity_credential_v3.user_aksk.secret
  description = "OBS bucket secret key for the created user. Can only access to the specific bucket and the specific KMS key used for bucket encryption."
  sensitive   = true
}
