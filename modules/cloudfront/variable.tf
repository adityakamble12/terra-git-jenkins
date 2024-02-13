variable "bucket_id" {
  description = "The ID of the existing S3 bucket to apply public access block settings"
  type        = string
}

variable "block_public_acls" {
  description = "Specifies whether Amazon S3 should block public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Specifies whether Amazon S3 should block public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Specifies whether Amazon S3 should ignore public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Specifies whether Amazon S3 should restrict public bucket policies for this bucket"
  type        = bool
  default     = true
}


variable "s3_bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  type        = string
}

variable "cloudfront_distribution_description" {
  description = "Comment for the CloudFront Distribution"
  type        = string
}

variable "enabled" {
  description = "Whether the CloudFront distribution is enabled"
  type        = bool
}

variable "is_ipv6_enabled" {
  description = "Whether IPv6 is enabled for the CloudFront distribution"
  type        = bool
}

variable "default_root_object" {
  description = "Default root object for the CloudFront distribution"
  type        = string
}
variable "use_default_certificate" {
  description = "Whether to use the CloudFront default SSL/TLS certificate"
  type        = bool
}

variable "origin_id" {
  description = "ID for the CloudFront distribution origin"
  type        = string
}

variable "origin_access_identity" {
  description = "Origin access identity for the S3 origin"
  type        = string
}

variable "viewer_protocol_policy" {
  description = "Viewer protocol policy for the CloudFront distribution"
  type        = string
}

variable "allowed_methods" {
  description = "List of allowed HTTP methods"
  type        = list(string)
}

variable "cached_methods" {
  description = "List of cached HTTP methods"
  type        = list(string)
}


variable "forwarded_values_query_string" {
  description = "Whether to forward query strings"
  type        = bool
}

variable "forwarded_values_cookies_forward" {
  description = "Forward cookies setting"
  type        = string
}

variable "min_ttl" {
  description = "Minimum TTL for objects in the CloudFront cache"
  type        = number
}

variable "default_ttl" {
  description = "Default TTL for objects in the CloudFront cache"
  type        = number
}

variable "max_ttl" {
  description = "Maximum TTL for objects in the CloudFront cache"
  type        = number
}

variable "additional_cache_behavior_origin_id" {
  description = "ID for the CloudFront distribution origin"
  type        = string
}

variable "additional_cache_behavior_viewer_protocol_policy" {
  description = "Viewer protocol policy for the CloudFront distribution"
  type        = string
}

variable "additional_cache_behavior_path_pattern" {
  description = "Path pattern for additional cache behavior"
  type        = string
}

variable "additional_cache_behavior_allowed_methods" {
  description = "List of allowed HTTP methods for additional cache behavior"
  type        = list(string)
}

variable "additional_cache_behavior_cached_methods" {
  description = "List of cached HTTP methods for additional cache behavior"
  type        = list(string)
}

variable "additional_cache_behavior_forwarded_values_query_string" {
  description = "Whether to forward query strings for additional cache behavior"
  type        = bool
}

variable "additional_cache_behavior_forwarded_values_cookies_forward" {
  description = "Forward cookies setting for additional cache behavior"
  type        = string
}

variable "additional_cache_behavior_min_ttl" {
  description = "Minimum TTL for objects in the CloudFront cache for additional cache behavior"
  type        = number
}

variable "additional_cache_behavior_default_ttl" {
  description = "Default TTL for objects in the CloudFront cache for additional cache behavior"
  type        = number
}

variable "additional_cache_behavior_max_ttl" {
  description = "Maximum TTL for objects in the CloudFront cache for additional cache behavior"
  type        = number
}

variable "additional_cache_behavior_compress" {
  description = "Whether to compress for additional cache behavior"
  type        = bool
}


variable "price_class" {
  description = "Price class for the CloudFront distribution"
  type        = string
}


variable "logging_bucket" {
  description = "S3 bucket for CloudFront logs"
  type        = string
}

variable "logging_include_cookies" {
  description = "Include cookies in CloudFront logs"
  type        = bool
}

variable "logging_prefix" {
  description = "Prefix for CloudFront logs"
  type        = string
}


variable "geo_restriction_type" {
  description = "Type of geo-restriction"
  type        = string
}

variable "geo_restriction_locations" {
  description = "List of geo-locations for restriction"
  type        = list(string)
}


variable "custom_error_response_enabled" {
  description = "Enable custom error response"
  type        = bool
}

variable "custom_error_response_error_code" {
  description = "Error code for the custom error response"
  type        = number
}

variable "custom_error_response_response_code" {
  description = "Response code for the custom error response"
  type        = number
}

variable "custom_error_response_page_path" {
  description = "Path for the custom error response page"
  type        = string
}

/*
variable "aliases" {
  description = "List of alternate domain names (CNAMEs)"
  type        = list(string)
}
*/

variable "supported_http_version" {
  description = "Supported HTTP version for CloudFront distribution"
  type        = string
}

variable "tags" {
  description = "Tags for the CloudFront distribution"
  type        = map(string)
}