terraform {
  backend "s3" {
    bucket = "my-terraform-backend-files"
    key    = "rds-terraform.tfstate"
    region = "us-east-1"
  }
}
