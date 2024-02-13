
resource "aws_s3_bucket_public_access_block" "example_public_access_block" {
  bucket = var.bucket_id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_cloudfront_distribution" "example_distribution" {
  origin {
    domain_name = var.s3_bucket_domain_name
    origin_id   = var.origin_id

    s3_origin_config {
      origin_access_identity = var.origin_access_identity
    }
  }

  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  comment             = var.cloudfront_distribution_description
  default_root_object = var.default_root_object

  viewer_certificate {
    cloudfront_default_certificate = var.use_default_certificate
  }

  # Default Cache Behavior Settings
  default_cache_behavior {
    target_origin_id       = var.origin_id
    viewer_protocol_policy = var.viewer_protocol_policy
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods

    forwarded_values {
      query_string = var.forwarded_values_query_string

      cookies {
        forward = var.forwarded_values_cookies_forward
      }
    }

    min_ttl     = var.min_ttl
    default_ttl = var.default_ttl
    max_ttl     = var.max_ttl
  }

  # Additional Cache Behaviors
  ordered_cache_behavior {
    target_origin_id       = var.additional_cache_behavior_origin_id
    path_pattern           = var.additional_cache_behavior_path_pattern
    viewer_protocol_policy = var.additional_cache_behavior_viewer_protocol_policy
    allowed_methods        = var.additional_cache_behavior_allowed_methods
    cached_methods         = var.additional_cache_behavior_cached_methods

    forwarded_values {
      query_string = var.additional_cache_behavior_forwarded_values_query_string

      cookies {
        forward = var.additional_cache_behavior_forwarded_values_cookies_forward
      }
    }

    min_ttl     = var.additional_cache_behavior_min_ttl
    default_ttl = var.additional_cache_behavior_default_ttl
    max_ttl     = var.additional_cache_behavior_max_ttl
    compress    = var.additional_cache_behavior_compress
  }

  # Price Class
  price_class = var.price_class

  # Logging
  logging_config {
    bucket          = var.logging_bucket
    include_cookies = var.logging_include_cookies
    prefix          = var.logging_prefix
  }

  # Restrictions
  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }

  dynamic "custom_error_response" {
    for_each = var.custom_error_response_enabled ? [1] : []
    content {
      error_code         = var.custom_error_response_error_code
      response_code      = var.custom_error_response_response_code
      response_page_path = var.custom_error_response_page_path
    }
  }

  /*
  # Alternate Domain Names (CNAMEs)
  aliases = var.aliases
*/

  # Supported HTTP Versions
  http_version = var.supported_http_version

  # Tags
  tags = var.tags
}

