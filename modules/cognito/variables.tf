
variable "userpool_name" {
  description = "Name of the Cognito user pool"
  type        = string
}

variable "email_attribute_name" {
  description = "Name of the email attribute"
  type        = string
}

variable "attribute_data_type" {
  description = "Data type of the attribute"
  type        = string
}

variable "mutable_attribute" {
  description = "Whether the attribute is mutable or not"
  type        = bool
}

variable "developer_only_attribute" {
  description = "Whether the attribute is for developers only"
  type        = bool
}

variable "email_sending_account" {
  description = "Email sending account for configuration"
  type        = string
}

variable "auto_verified_attributes" {
  description = "List of auto-verified attributes"
  type        = list(string)
}

variable "minimum_password_length" {
  description = "Minimum length for user passwords"
  type        = number
}

variable "require_lowercase" {
  description = "Require at least one lowercase letter in the password"
  type        = bool
}

variable "require_numbers" {
  description = "Require at least one number in the password"
  type        = bool
}

variable "require_symbols" {
  description = "Require at least one symbol in the password"
  type        = bool
}

variable "require_uppercase" {
  description = "Require at least one uppercase letter in the password"
  type        = bool
}

variable "temporary_password_validity_days" {
  description = "Validity period for temporary passwords in days"
  type        = number
}

variable "username_attributes" {
  description = "Attributes used as the username"
  type        = list(string)
}

variable "case_sensitive_username" {
  description = "Is the username case-sensitive"
  type        = bool
}

variable "tags" {
  description = "Tags to be applied to the Cognito user pool"
  type        = map(string)
}

variable "client_name" {
  description = "Name of the Cognito user pool client"
  type        = string
}

variable "supported_identity_providers" {
  description = "List of supported identity providers"
  type        = list(string)
}

variable "explicit_auth_flows" {
  description = "List of explicit authentication flows"
  type        = list(string)
}

variable "generate_secret" {
  description = "Specifies whether to generate a client secret"
  type        = bool
}

variable "prevent_user_existence_errors" {
  description = "Behavior if a user with the same username exists"
  type        = string
}

variable "token_validity_hours" {
  description = "Validity period for tokens in hours"
  type        = number
}
