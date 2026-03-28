variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_count" {
  description = "How many public subnets to create"
  type        = number
  default     = 2
}

variable "private_subnet_count" {
  description = "How many private subnets to create"
  type        = number
  default     = 2
}

variable "common_tags" {
  description = "Tags applied to VPC resources"
  type        = map(string)
  default     = {}
}
