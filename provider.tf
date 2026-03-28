terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  # Uncomment the backend block after creating the S3 bucket
   backend "s3" {
     bucket  = "mytf-state-protection"
     key     = "terraform.tfstate"
     region  = "us-east-1"
     encrypt = true
   }
}

provider "aws" {
  region = var.aws_region
}
