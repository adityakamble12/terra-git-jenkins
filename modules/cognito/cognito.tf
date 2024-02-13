
resource "aws_cognito_user_pool" "userpool" {
  name = var.userpool_name

  # Schema for the attributes
  schema {
    name                     = var.email_attribute_name
    attribute_data_type      = var.attribute_data_type
    mutable                  = var.mutable_attribute
    developer_only_attribute = var.developer_only_attribute
  }

  # Email configuration
  email_configuration {
    email_sending_account = var.email_sending_account
  }

  auto_verified_attributes = var.auto_verified_attributes

  # Password policy
  password_policy {
    minimum_length                   = var.minimum_password_length
    require_lowercase                = var.require_lowercase
    require_numbers                  = var.require_numbers
    require_symbols                  = var.require_symbols
    require_uppercase                = var.require_uppercase
    temporary_password_validity_days = var.temporary_password_validity_days
  }

  username_attributes = var.username_attributes
  username_configuration {
    case_sensitive = var.case_sensitive_username
  }

  # Account recovery settings
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  # User pool tags
  tags = var.tags
}

resource "aws_cognito_user_pool_client" "userpool_client" {
  name                          = var.client_name
  user_pool_id                  = aws_cognito_user_pool.userpool.id
  supported_identity_providers  = var.supported_identity_providers
  explicit_auth_flows           = var.explicit_auth_flows
  generate_secret               = var.generate_secret
  prevent_user_existence_errors = var.prevent_user_existence_errors
  refresh_token_validity        = var.token_validity_hours
  access_token_validity         = var.token_validity_hours
  id_token_validity             = var.token_validity_hours

  token_validity_units {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "hours"
  }
}