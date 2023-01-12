terraform {
  backend "s3" {
    bucket = "my-terraform-backend-files"
    key    = "dev/wordpress.tfstate"
    region = "us-east-1"
  }
}
