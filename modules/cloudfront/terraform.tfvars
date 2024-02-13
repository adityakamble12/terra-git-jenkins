bucket_id               = module.s3.bucket.id
block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true

s3_bucket_domain_name               = "testy-buccy.s3.us-east-2.amazonaws.com"
cloudfront_distribution_description = "This is the CloudFront Distribution"
enabled                             = true
is_ipv6_enabled                     = true
default_root_object                 = "index.html"
use_default_certificate             = true
origin_id                           = "S3Origin"                                     # Example value, change as needed
origin_access_identity              = "origin-access-identity/cloudfront/EXAMPLE123" # Example value, change as needed

viewer_protocol_policy = "allow-all" # Options: "allow-all", "https-only", "redirect-to-https"

allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]

cached_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]

forwarded_values_query_string    = false
forwarded_values_cookies_forward = "none"
min_ttl                          = 0
default_ttl                      = 3600
max_ttl                          = 86400

additional_cache_behavior_viewer_protocol_policy           = "allow-all" # Options: "allow-all", "https-only", "redirect-to-https"
additional_cache_behavior_origin_id                        = "S3Origin"
additional_cache_behavior_path_pattern                     = "/images/*"
additional_cache_behavior_allowed_methods                  = ["GET", "HEAD", "OPTIONS"]
additional_cache_behavior_cached_methods                   = ["GET", "HEAD"]
additional_cache_behavior_forwarded_values_query_string    = true
additional_cache_behavior_forwarded_values_cookies_forward = "all"
additional_cache_behavior_min_ttl                          = 3600
additional_cache_behavior_default_ttl                      = 86400
additional_cache_behavior_max_ttl                          = 2592000
additional_cache_behavior_compress                         = true

price_class = "PriceClass_All" # Options: "PriceClass_All", "PriceClass_100", "PriceClass_200"

logging_bucket          = "testy-buccy"
logging_include_cookies = false
logging_prefix          = "cloudfront-logs/"

geo_restriction_type      = "none" # Options: "whitelist", "blacklist", none []
geo_restriction_locations = []     # Include all locations you want to

custom_error_response_enabled       = true
custom_error_response_error_code    = 404
custom_error_response_response_code = 200
custom_error_response_page_path     = "/index.html"

#aliases = ["example.com", "www.example.com"]

supported_http_version = "http2" # You can change this to "http1.1" if needed

tags = {
  environment = "Dev"
  project     = "Test-project"
}