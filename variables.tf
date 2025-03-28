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
