
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  shared_config_files      = ["/home/oem/.aws/config"]
  shared_credentials_files = ["/home/oem/.aws/credentials"]
  profile                  = "default"
}
