
bucket_name           = "testy-buccy"
status_versioning     = "Enabled"
logging_target_bucket = "testy-buccy"
logging_target_prefix = "logs/"

#S3 Bucket Access Block
block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true

 tags = {
    Name        = "ExampleBucket"
    Environment = "Production"
  }
