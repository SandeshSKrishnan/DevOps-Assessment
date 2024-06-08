terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-west-2"
  # Optional: 
  # profile    = "your-aws-profile" 
  # access_key = "your-access-key"
  # secret_key = "your-secret-key"
}
