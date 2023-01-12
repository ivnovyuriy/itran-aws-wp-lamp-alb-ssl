terraform {
  required_version = "~> 1.3.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.35.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}