variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default     = 2
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
  default     = 2
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into EC2 (your laptop IP)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "create_ec2" {
  description = "If false, EC2 instance creation is skipped"
  type        = bool
  default     = true
}

variable "key_name" {
  description = "Name of existing key pair to use for EC2"
  type        = string
  default     = ""
}

variable "create_key_pair" {
  description = "If true, create a new key pair when key_name is empty"
  type        = bool
  default     = true
}

variable "ami_name_pattern" {
  description = "AMI name glob pattern to find Ubuntu image"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "resource_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    created_by = "terraform"
  }
}

variable "terraform_state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "mytf-state"
}
