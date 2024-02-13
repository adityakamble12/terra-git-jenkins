
userpool_name            = "my-userpool"
email_attribute_name     = "Email"
attribute_data_type      = "String"
mutable_attribute        = true
developer_only_attribute = false
email_sending_account    = "COGNITO_DEFAULT"
auto_verified_attributes = ["email"]

minimum_password_length          = 6
require_lowercase                = true
require_numbers                  = true
require_symbols                  = true
require_uppercase                = true
temporary_password_validity_days = 15

username_attributes     = ["email"]
case_sensitive_username = true

tags = {
  Environment = "Production"
  Owner       = "Team-Global"

}

client_name                  = "my-client"
supported_identity_providers = ["COGNITO"]
explicit_auth_flows = [
  "ALLOW_USER_PASSWORD_AUTH",
  "ALLOW_REFRESH_TOKEN_AUTH",
  "ALLOW_ADMIN_USER_PASSWORD_AUTH"

]
generate_secret               = false
prevent_user_existence_errors = "LEGACY"
token_validity_hours          = 1
