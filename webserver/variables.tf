variable "aws_region" {
  type        = string
  description = "the region where resources will be provisioned"
  default     = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "env" {
  type        = string
  description = "name of the environment"
  default     = "dev"
}

variable "key_name" {
  type    = string
  default = "mykeys"
}

variable "zone_name" {
  description = "Name of route 53 zone"
  type        = string
  default     = "ivanovyuriy.com."
}