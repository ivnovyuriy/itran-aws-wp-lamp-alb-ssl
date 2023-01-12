data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "my-terraform-backend-files"
    key    = "dev/vpc.tfstate"
    region = "us-east-1"
  }
}
