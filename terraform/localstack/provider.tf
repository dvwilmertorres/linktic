provider "aws" {
  region                      = var.aws_region
  access_key                  = "fake"
  secret_key                  = "fake"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    ec2             = "http://localhost:4566"
    route53         = "http://localhost:4566"
    route53resolver = "http://localhost:4566"
    s3              = "http://localhost:4566"
    s3control       = "http://localhost:4566"
    rds             = "http://localhost:4566"
  }
  default_tags {
    tags = {
      Enviroment = "Local"
      Service    = "localStack"
    }
  }
}
terraform {
  required_version = "=1.8.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.60.0, <= 5.54.1"
    }
  }
}
