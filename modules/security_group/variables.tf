variable "vpc_id" {
  description = "VPC where security group will be created"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR to allow internal TCP"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "IP range that can SSH (for example your laptop public IP)"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to security group"
  type        = map(string)
  default     = {}
}
