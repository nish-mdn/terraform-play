module "s3" {
  source      = "./modules/s3"
  bucket_name = var.terraform_state_bucket_name
  common_tags = var.resource_tags
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_count = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  common_tags         = var.resource_tags
}

module "security_group" {
  source          = "./modules/security_group"
  vpc_id          = module.vpc.vpc_id
  vpc_cidr        = module.vpc.vpc_cidr
  ssh_allowed_cidr = var.ssh_allowed_cidr
  common_tags      = var.resource_tags
}

module "ec2" {
  source            = "./modules/ec2"
  subnet_id         = module.vpc.public_subnet_ids[0]
  sg_id             = module.security_group.sg_id
  instance_type     = var.instance_type
  region            = var.aws_region
  create_ec2        = var.create_ec2
  key_name          = var.key_name
  create_key_pair   = var.create_key_pair
  ami_name_pattern  = var.ami_name_pattern
  common_tags       = var.resource_tags
}
