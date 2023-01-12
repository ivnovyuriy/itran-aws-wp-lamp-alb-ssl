terraform {
  backend "s3" {
    bucket = "my-terraform-backend-files"
    key    = "dev/vpc.tfstate"
    region = "us-east-1"
  }
}
