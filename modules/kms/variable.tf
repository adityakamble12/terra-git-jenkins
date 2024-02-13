
variable "kms_description" {
  description = "Description for the KMS Key"
}

variable "enable_key_rotation" {
  description = "Enable key rotation"
}

variable "key_usage" {
  description = "Key usage type"
}

variable "deletion_window_in_days" {
  description = "Key deletion window in days"
}

variable "is_enabled" {
  description = "Enable the key"
}

variable "customer_master_key_spec" {
  description = "Customer master key specification"
}

variable "origin" {
  description = "Origin of the key material"
}

variable "tags" {
  description = "Map of tags"
  type        = map(string)
  default     = {}
}

