
email_identity = "mail_id@gmail.com"

domain_name            = "your_domain.com"
mail_from_domain       = "mail@domain.com"
behavior_on_mx_failure = "UseDefaultValue"

configuration_set_name    = "example-config-set-20240130"
enable_reputation_metrics = true

receipt_rule_set_name    = "transactional-emails-rule-set"
receipt_rule_name        = "archive-transactions"
enable_receipt_rule      = true
receipt_rule_recipients  = ["mail_id@gmail.com"]
enable_receipt_rule_scan = true

s3_actions = [
  {
    bucket_name       = "test-ses-adi"
    object_key_prefix = "emails/"
    #topic_arn         = "arn:aws:sns:us-east-1:123456789012:example-sns-topic-1"
  }
]

add_header_actions = [
  {
    header_name  = "X-Custom-Header-1"
    header_value = "ExampleHeaderValue1"
  }
]
