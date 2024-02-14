

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
  backend "s3" {
    #Remote Backend:

    region = "us-east-2"

    #S3 Bucket name that we have created:
    bucket = "mera-terra-state-tf"

    #State file location on S3
    key = "tf-state/terraform.tfstate"

    #State-Locking
    #DynamoDB table name that we have created:
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}

# Configure the AWS Provider
provider "aws" {
  shared_config_files      = ["/var/lib/jenkins/.aws/config"]
  shared_credentials_files = ["/var/lib/jenkins/.aws/credentials"]
  profile                  = "default"
}


# S3 module:
module "s3_bucket" {
  source = "./modules/s3"

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
}


# RDS module:
module "aurora_db" {
  source = "./modules/rds"

  cluster_identifier        = "test-adi-db"
  engine                    = "aurora-postgresql"
  engine_version            = "11.9"
  engine_mode               = "serverless"
  db_name                   = "postgres"
  master_username           = "postgres"
  master_password           = "password"
  final_snapshot_identifier = "my-final-snapshot"
  skip_final_snapshot       = true
  backup_retention_period   = 14
  deletion_protection       = true
  auto_pause                = true
  max_capacity              = 4
  min_capacity              = 2
  seconds_until_auto_pause  = 300
  timeout_action            = "RollbackCapacityChange"
  enable_http_endpoint      = true
  subnet_ids                = ["subnet-034ead9147278af43", "subnet-082970352785795e3", "subnet-094258f2f76605abc"] # Replace these with your actual subnet IDs
}


# cOGNITO module:
module "my_cognito" {
  source = "./modules/cognito"

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

}


# API GATEWAY module:
module "my_apigateway" {
  source = "./modules/apigateway"

  api_name        = "MyRESTAPI"
  api_description = "Custom description for the API"
  endpoint_type   = "REGIONAL"

  api_name_2                 = "MyWEBSOCKETAPI"
  api_description_2          = "Custom description for the WebSocket API"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.route"
  api_version                = "1"

}


#ALB module:
module "my_module" {
  source = "./modules/alb_asg"

  # Create Security Groups
  security_group_name = "my-terra-alb" # Replace with your desired security group name

  # Define ingress rules for HTTP
  http_ingress = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]


  # Define ingress rules for HTTPS   (need to comment before running)
  #https_ingress = [
  #  {
  #    from_port   = 443
  #    to_port     = 443
  #    protocol    = "tcp"
  #    cidr_blocks = ["0.0.0.0/0"]
  #  }
  #]


  # Define outbound traffic rules
  outbound_traffic = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  # Create Application Load Balancer
  loadbalancer_name = "terra-load-balancer"
  alb_internal      = false
  alb_type          = "application"
  ip_address_type   = "ipv4"
  alb_subnets       = ["subnet-034ead9147278af43", "subnet-082970352785795e3", "subnet-094258f2f76605abc"] # Replace with your subnet IDs


  # Create Target Group
  target_group_name     = "terra-target-group"
  target_group_port     = 80
  target_group_protocol = "HTTP"
  vpc_id                = "vpc-0103ff4c9e5ac099a"

  target_group_health_check_enabled             = true
  target_group_health_check_protocol            = "HTTP"
  target_group_health_check_port                = 80
  target_group_health_check_path                = "/"
  target_group_health_check_interval            = 30
  target_group_health_check_timeout             = 5
  target_group_health_check_healthy_threshold   = 2
  target_group_health_check_unhealthy_threshold = 2
  target_group_health_check_success_codes       = 200

  # Tags for the target group
  target_group_tags = {
    Name = "terra-target-group"
  }


  # Register targets (instances or Lambda functions) with the Target Group   (need to comment before running)
  #instance_ip         = "52.14.193.46"
  #instance_port       = 80
  #lambda_function_arn = "arn:aws:lambda:us-west-2:123456789012:function:my-lambda-function"
  #lambda_port         = 80


  # Create Listeners and Routing
  listener_port       = 80
  listener_protocol   = "HTTP"
  default_action_type = "forward"


  #https_listener_port       = 443              (need to comment before running)
  #https_listener_protocol   = "HTTPS"
  #https_default_action_type = "forward"


  # Create Launch Template
  launch_template_name = "terra-launch-template"
  device_name          = "/dev/sda1"
  volume_size          = 30
  ami_id               = "ami-05fb0b8c1424f266b"
  instance_type        = "t2.micro"
  key_name             = "training_key"
  subnets              = ["subnet-034ead9147278af43", "subnet-082970352785795e3", "subnet-094258f2f76605abc"]

  # Create Auto Scaling Group
  asg_name                  = "terra-asg"
  desired_capacity          = 2
  max_size                  = 5
  min_size                  = 1
  health_check_type         = "ELB"
  health_check_grace_period = 300
  launch_template_version   = "$Latest"

  # Define your tags
  tags = {
    Name = "terra-asg"
  }

  # Propagate at launch
  propagate_at_launch = true

  cloudwatch_enabled_metrics = false
}


/*
# SES module:
module "ses" {
  source = "./modules/ses"

email_identity = "kambleaditya256@gmail.com"

domain_name            = "chingya.xyz"
mail_from_domain       = "chingya.xyz"
behavior_on_mx_failure = "UseDefaultValue"

configuration_set_name    = "example-config-set-20240130"
enable_reputation_metrics = true

receipt_rule_set_name    = "transactional-emails-rule-set"
receipt_rule_name        = "archive-transactions"
enable_receipt_rule      = true
receipt_rule_recipients  = ["kambleaditya256@gmail.com"]
enable_receipt_rule_scan = true

s3_actions = [
  {
    bucket_name       = "testy-buccy"
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
}


# CLOUDFRONT module:
module "my_cloudfront" {
  source = "./modules/cloudfront"

  bucket_id               = module.s3_bucket.bucket_id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  s3_bucket_domain_name               = module.s3_bucket.bucket_id
  cloudfront_distribution_description = "This is the CloudFront Distribution"
  enabled                             = true
  is_ipv6_enabled                     = true
  default_root_object                 = "index.html"
  use_default_certificate             = true
  origin_id                           = module.s3_bucket.bucket_id                                     # Example value, change as needed
  origin_access_identity              = module.s3_bucket.bucket_id # Example value, change as needed

  viewer_protocol_policy = "allow-all" # Options: "allow-all", "https-only", "redirect-to-https"

  allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]

  cached_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]

  forwarded_values_query_string    = false
  forwarded_values_cookies_forward = "none"
  min_ttl                          = 0
  default_ttl                      = 3600
  max_ttl                          = 86400

  additional_cache_behavior_viewer_protocol_policy           = "allow-all" # Options: "allow-all", "https-only", "redirect-to-https"
  additional_cache_behavior_origin_id                        = module.s3_bucket.bucket_id
  additional_cache_behavior_path_pattern                     = "/images/*"
  additional_cache_behavior_allowed_methods                  = ["GET", "HEAD", "OPTIONS"]
  additional_cache_behavior_cached_methods                   = ["GET", "HEAD"]
  additional_cache_behavior_forwarded_values_query_string    = true
  additional_cache_behavior_forwarded_values_cookies_forward = "all"
  additional_cache_behavior_min_ttl                          = 3600
  additional_cache_behavior_default_ttl                      = 86400
  additional_cache_behavior_max_ttl                          = 2592000
  additional_cache_behavior_compress                         = true

  price_class = "PriceClass_All" # Options: "PriceClass_All", "PriceClass_100", "PriceClass_200"

  logging_bucket          = module.s3_bucket.bucket_id
  logging_include_cookies = false
  logging_prefix          = "cloudfront-logs/"

  geo_restriction_type      = "none" # Options: "whitelist", "blacklist", none []
  geo_restriction_locations = []     # Include all locations you want to

  custom_error_response_enabled       = true
  custom_error_response_error_code    = 404
  custom_error_response_response_code = 200
  custom_error_response_page_path     = "/index.html"

  #aliases = ["example.com", "www.example.com"]

  supported_http_version = "http2" # You can change this to "http1.1" if needed

  tags = {
    environment = "Dev"
    project     = "Test-project"
  }

}   

*/
