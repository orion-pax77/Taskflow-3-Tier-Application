variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "taskflow-cluster"
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "c7i-flex.large"
}

variable "node_min" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 2
}

variable "node_max" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}

variable "node_desired" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default = {
    Project     = "TaskFlow"
    ManagedBy   = "Terraform"
    Environment = "production"
  }
}
