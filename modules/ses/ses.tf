
resource "aws_ses_email_identity" "example_domain" {
  email = var.email_identity
}

resource "aws_ses_domain_identity" "example_domain" {
  domain = var.domain_name
}

resource "aws_ses_domain_mail_from" "example_domain" {
  domain                 = aws_ses_domain_identity.example_domain.domain
  mail_from_domain       = var.mail_from_domain
  behavior_on_mx_failure = var.behavior_on_mx_failure
}

resource "aws_ses_configuration_set" "example_set" {
  name                       = var.configuration_set_name
  reputation_metrics_enabled = var.enable_reputation_metrics
}

resource "aws_ses_receipt_rule_set" "example_set" {
  rule_set_name = var.receipt_rule_set_name
}

resource "aws_ses_receipt_rule" "example_rule" {
  rule_set_name = aws_ses_receipt_rule_set.example_set.rule_set_name
  name          = var.receipt_rule_name

  enabled      = var.enable_receipt_rule
  recipients   = var.receipt_rule_recipients
  scan_enabled = var.enable_receipt_rule_scan

  # Configure S3 action
  dynamic "s3_action" {
    for_each = var.s3_actions
    content {
      position          = s3_action.key + 1 # Define position here
      bucket_name       = s3_action.value.bucket_name
      object_key_prefix = s3_action.value.object_key_prefix
      #topic_arn         = s3_action.value.topic_arn
    }
  }

  # Configure add header action
  dynamic "add_header_action" {
    for_each = var.add_header_actions
    content {
      position     = add_header_action.key + 1 # Define position here
      header_name  = add_header_action.value.header_name
      header_value = add_header_action.value.header_value
    }
  }
}