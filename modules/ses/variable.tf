
variable "email_identity" {
  description = "Email identity"
}

variable "domain_name" {
  description = "SES domain name"
}

variable "mail_from_domain" {
  description = "SES mail from domain"
}

variable "behavior_on_mx_failure" {
  description = "SES behavior on MX failure"
}

variable "configuration_set_name" {
  description = "SES configuration set name"
}

variable "enable_reputation_metrics" {
  description = "Enable reputation metrics for SES configuration set"
}

variable "receipt_rule_set_name" {
  description = "SES receipt rule set name"
}

variable "receipt_rule_name" {
  description = "SES receipt rule name"
}

variable "enable_receipt_rule" {
  description = "Enable SES receipt rule"
}

variable "receipt_rule_recipients" {
  type        = list(string)
  description = "Recipients for the SES receipt rule."
}

variable "enable_receipt_rule_scan" {
  description = "Enable scan for SES receipt rule"
}

variable "s3_actions" {
  type = list(object({
    bucket_name       = string
    object_key_prefix = string
    topic_arn         = optional(string)  # Making topic_arn optional
  }))
  description = "List of S3 actions for SES receipt rule"
}

variable "add_header_actions" {
  type = list(object({
    header_name  = string
    header_value = string
  }))
  description = "List of add header actions for SES receipt rule"
}

