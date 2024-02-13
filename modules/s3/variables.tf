
variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "status_versioning" {
  description = "Enable versioning for the bucket"
  type        = string
}

variable "logging_target_bucket" {
  description = "Bucket to store access logs"
  type        = string
}

variable "logging_target_prefix" {
  description = "Prefix for access logs in the target bucket"
  type        = string
}

variable "tags" {
  description = "Additional tags for the S3 bucket"
  type        = map(string)
}

variable "block_public_acls" {
  description = "Controls whether Amazon S3 should block public ACLs for this bucket"
  type        = bool
}

variable "block_public_policy" {
  description = "Controls whether Amazon S3 should block public bucket policies for this bucket"
  type        = bool
}

variable "ignore_public_acls" {
  description = "Controls whether Amazon S3 should ignore public ACLs for this bucket"
  type        = bool
}

variable "restrict_public_buckets" {
  description = "Controls whether Amazon S3 should restrict public bucket policies for this bucket"
  type        = bool
}
