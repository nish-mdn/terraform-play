data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  total_subnets = var.public_subnet_count + var.private_subnet_count

  subnet_new_bits = (local.total_subnets == 1 ? 0 :
    local.total_subnets <= 2 ? 1 :
    local.total_subnets <= 4 ? 2 :
    local.total_subnets <= 8 ? 3 :
    local.total_subnets <= 16 ? 4 :
    5)
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge({
    Name = "example-vpc"
  }, var.common_tags)
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge({
    Name = "example-igw"
  }, var.common_tags)
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge({
    Name = "public-rt"
  }, var.common_tags)
}

resource "aws_subnet" "public" {
  count             = var.public_subnet_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, local.subnet_new_bits, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = merge({
    Name = "public-${count.index}"
  }, var.common_tags)
}

resource "aws_route_table_association" "public" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "private" {
  count             = var.private_subnet_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, local.subnet_new_bits, var.public_subnet_count + count.index)
  availability_zone = data.aws_availability_zones.available.names[var.public_subnet_count + count.index]

  tags = merge({
    Name = "private-${count.index}"
  }, var.common_tags)
}
