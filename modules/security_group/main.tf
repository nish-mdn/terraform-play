resource "aws_security_group" "this" {
  name        = "example-sg"
  description = "SG allows SSH from laptop + TCP inside VPC"
  vpc_id      = var.vpc_id

  ingress {
    description      = "SSH from allowed CIDR"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.ssh_allowed_cidr]
    ipv6_cidr_blocks = []
  }

  ingress {
    description      = "All TCP within VPC"
    from_port        = 1
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr]
    ipv6_cidr_blocks = []
  }

  egress {
    description      = "Allow all outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge({
    Name = "example-sg"
  }, var.common_tags)
}
