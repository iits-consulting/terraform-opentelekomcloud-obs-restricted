variable "bucket_name" {
  type        = string
  description = "Bucket name. Make sure the provider for this module has tennant_name=<region> set"
  validation {
    condition     = length("${var.bucket_name}-user") <= 32
    error_message = "The username for the bucket user may only be max 32 characters long."
  }
}

variable "enable_versioning" {
  type        = bool
  description = "Disable the versioning for the bucket. Default: true"
  default     = true
}

variable "enable_sse" {
  type        = bool
  description = "Enable KMS server side encryption for buckets. Default: true"
  default     = true
}

variable "kms_key_rotation_interval" {
  # Has no effect if enable_sse is false.
  type        = number
  description = "Rotation interval in days (30-365) for the KMS key created by this module. Setting a value enables automatic key rotation. null turns rotation off, also on a key where it was enabled outside of Terraform. Has no effect if enable_sse is false. (default: null)"
  default     = null
  validation {
    condition     = var.kms_key_rotation_interval == null ? true : var.kms_key_rotation_interval >= 30 && var.kms_key_rotation_interval <= 365
    error_message = "kms_key_rotation_interval not in range 30 <= x <= 365"
  }
}

variable "force_destroy" {
  type        = bool
  description = "Destroy all objects from the bucket so that the bucket can be destroyed without error."
  default     = false
}

variable "tags" {
  type    = map(string)
  default = null
}

variable "worm_policy" {
  type = object({
    years = optional(number)
    days  = optional(number)
  })
  description = "[Optional] Enables and sets number of years OR days for the WORM policy retention period. Only one can be set, not both."
  default     = null
}

variable "lifecycle_rules" {
  type = list(object({
    name    = string
    enabled = bool
    prefix  = optional(string)
    tags = optional(list(object({
      key   = string
      value = string
    })))
    expiration = optional(object({
      days = number
    }))
    transitions = optional(list(object({
      days          = number
      storage_class = string
    })))
    noncurrent_version_expiration = optional(object({
      days = number
    }))
    noncurrent_version_transitions = optional(list(object({
      days          = number
      storage_class = string
    })))
    abort_incomplete_multipart_upload = optional(object({
      days = number
    }))
  }))
  description = "Lifecycle rules for the bucket. Default: null"
  default     = []
}
