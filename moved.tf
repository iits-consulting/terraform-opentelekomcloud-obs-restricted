moved {
  from = random_id.bucket_kms_key_id
  to   = random_id.bucket_kms_key_id[0]
}
moved {
  from = opentelekomcloud_kms_key_v1.bucket_kms_key
  to   = opentelekomcloud_kms_key_v1.bucket_kms_key[0]
}
moved {
  from = opentelekomcloud_identity_role_v3.kms_access
  to   = opentelekomcloud_identity_role_v3.kms_access[0]
}
moved {
  from = opentelekomcloud_identity_role_assignment_v3.kms_adm_to_obs_group
  to   = opentelekomcloud_identity_role_assignment_v3.kms_adm_to_obs_group[0]
}