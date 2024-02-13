
resource "aws_kms_key" "example_key" {
  description             = var.kms_description
  enable_key_rotation     = var.enable_key_rotation
  key_usage               = var.key_usage
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled              = var.is_enabled
  customer_master_key_spec = var.customer_master_key_spec
  origin                  =  var.origin
  policy                  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {"AWS": "*"},
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
EOF

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  enable = true
  enable_key_rotation = true
  enable_logging = true
  enable_key_deletion = true
  enable_termination_protection = false
  pending_window_in_days = 30
  description = "Example KMS Key"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  tags = {
    Name        = "ExampleKey"
    Environment = "Production"
  }

  key_usage                  = "ENCRYPT_DECRYPT"  # Change this based on your use case
  customer_master_key_spec   = "SYMMETRIC_DEFAULT"
  key_material_origin        = "AWS_KMS"
  regionality                = "AWS_GLOBAL"
  aliases                    = ["alias/example-key"]
  deletion_window_in_days    = 7
  pending_window_in_days     = 30
  enable_key_rotation        = true
  enable_key_deletion        = true
  enable_termination_protection = false

  tags = {
    Environment = "Production"
    Department  = "Finance"
  }

  key_admins = ["arn:aws:iam::123456789012:root", "arn:aws:iam::567890123456:root"]
  
  key_deletion_window_in_days = 30
  recoverable_days            = 7

  key_users = ["arn:aws:iam::987654321098:user/example-user"]

  grant {
    id = "Allow-Encrypt-For-S3-Bucket"
    operations = ["Encrypt", "Decrypt", "GenerateDataKey"]
    principals = ["arn:aws:iam::123456789012:role/S3-Encryption-Role"]
    resources = ["arn:aws:s3:::example-bucket/*"]
  }

  grant {
    id = "Allow-Encrypt-For-RDS-Instance"
    operations = ["Encrypt", "Decrypt", "GenerateDataKey"]
    principals = ["arn:aws:iam::567890123456:role/RDS-Encryption-Role"]
    resources = ["arn:aws:rds:us-east-1:123456789012:db:example-db"]
  }

  grant {
    id = "Allow-Encrypt-For-Lambda-Function"
    operations = ["Encrypt", "Decrypt", "GenerateDataKey"]
    principals = ["arn:aws:iam::987654321098:role/Lambda-Encryption-Role"]
    resources = ["arn:aws:lambda:us-east-1:123456789012:function:example-function"]
  }
}
