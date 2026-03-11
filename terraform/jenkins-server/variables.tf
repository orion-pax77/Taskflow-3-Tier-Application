variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "c7i-flex.large"
}

variable "key_name" {
  description = "Name of your EC2 key pair (create in AWS Console first)"
  type        = string
  default     = "eks-project-key"
}
