
resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_logging" "example_bucket_logging" {
  bucket = aws_s3_bucket.example_bucket.id

  target_bucket = var.logging_target_bucket
  target_prefix = var.logging_target_prefix
}

resource "aws_s3_bucket_versioning" "example_bucket_versioning" {
bucket = aws_s3_bucket.example_bucket.id

versioning_configuration {
  status = var.status_versioning
}
} 

resource "aws_s3_bucket_public_access_block" "my_block_bucket_access" {
  bucket = aws_s3_bucket.example_bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets

  depends_on = [aws_s3_bucket.example_bucket] # Ensures proper execution order
}
