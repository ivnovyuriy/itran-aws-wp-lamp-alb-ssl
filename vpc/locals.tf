locals {
  common_tags = {
    Environment = var.env
    Project     = "${var.env}-wordpress"
    Team        = "Development"
    Owner       = "ivanovyuriy@gmail.com"
  }
}