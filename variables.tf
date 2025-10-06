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

  validation {
    condition = alltrue([
      for rule in var.lifecycle_rules :
        rule.transitions == null ? true : alltrue([
          for transition in rule.transitions: contains(["WARM", "COLD"], transition.storage_class)
        ])
    ])
    error_message = "The storage_class in transition object has to be WARM or COLD"
  }
  validation {
    condition = alltrue([
      for rule in var.lifecycle_rules :
        rule.transitions == null ? true : length(rule.transitions) <= 2
    ])
    error_message = "Each lifecycle rule can have at most 2 transition entries."
  }
  validation {
    condition = alltrue([
      for rule in var.lifecycle_rules :
        rule.noncurrent_version_transitions == null ? true : alltrue([
          for transition in rule.noncurrent_version_transitions :
            contains(["WARM", "COLD"], transition.storage_class)
        ])
    ])
    error_message = "The storage_class in noncurrent_version_transition object has to be WARM or COLD"
  }
  validation {
    condition = alltrue([
      for rule in var.lifecycle_rules :
        rule.noncurrent_version_transitions == null ? true : length(rule.noncurrent_version_transitions) <= 2
    ])
    error_message = "Each lifecycle rule can have at most 2 noncurrent_version_transition entries."
  }
}
