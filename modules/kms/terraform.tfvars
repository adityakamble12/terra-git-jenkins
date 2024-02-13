
kms_description          = "Example KMS Key"
enable_key_rotation      = true
key_usage                = "ENCRYPT_DECRYPT"
deletion_window_in_days  = 7
is_enabled               = true
customer_master_key_spec = "SYMMETRIC_DEFAULT"
origin                   = "AWS_KMS"

tags = {
  Environment = "Production"
  Department  = "Finance"
}

