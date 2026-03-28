data "aws_ami" "ubuntu_24_latest" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_pattern]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "tls_private_key" "this" {
  count     = var.create_ec2 && var.create_key_pair && var.key_name == "" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  count      = var.create_ec2 && var.create_key_pair && var.key_name == "" ? 1 : 0
  key_name   = "terraform-ec2-key-${random_string.suffix[0].result}"
  public_key = tls_private_key.this[0].public_key_openssh

  tags = var.common_tags
}

resource "random_string" "suffix" {
  count   = var.create_ec2 && var.create_key_pair && var.key_name == "" ? 1 : 0
  length  = 8
  lower   = true
  upper   = false
  numeric = true
  special = false
}

resource "local_file" "private_key" {
  count    = var.create_ec2 && var.create_key_pair && var.key_name == "" ? 1 : 0
  content  = tls_private_key.this[0].private_key_pem
  filename = "${path.root}/terraform-ec2-key-${random_string.suffix[0].result}.pem"
}

locals {
  key_name = var.key_name != "" ? var.key_name : (var.create_key_pair ? aws_key_pair.this[0].key_name : "")
}

resource "aws_instance" "this" {
  count         = var.create_ec2 ? 1 : 0
  ami           = data.aws_ami.ubuntu_24_latest.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  associate_public_ip_address = true
  key_name      = local.key_name

  tags = merge({
    Name = "example-ec2"
  }, var.common_tags)
}

