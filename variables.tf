variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "Custom AMI ID with Nginx installed"
  type        = string
}

variable "key_name" {
  description = "Key pair for SSH"
  type        = string
}
