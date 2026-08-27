moved {
  from = random_id.bucket_kms_key_id
  to   = random_id.bucket_kms_key_id[0]
}
moved {
  from = opentelekomcloud_kms_key_v1.bucket_kms_key
  to   = opentelekomcloud_kms_key_v1.bucket_kms_key[0]
} 