variable "subnet_id" {
  description = "Subnet in which EC2 should be launched"
  type        = string
}

variable "sg_id" {
  description = "Security group id for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "region" {
  description = "AWS region for data source lookups"
  type        = string
  default     = "us-east-1"
}

variable "create_ec2" {
  description = "Whether to create EC2 resource"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common tags to apply to EC2"
  type        = map(string)
  default     = {}
}

variable "key_name" {
  description = "Name of the key pair to use for EC2. If not provided, a new key pair will be created"
  type        = string
  default     = "docker_host"
}

variable "create_key_pair" {
  description = "Whether to create a new key pair if key_name is not provided"
  type        = bool
  default     = false
}

variable "ami_name_pattern" {
  description = "AMI name glob pattern for Ubuntu 24 image"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

