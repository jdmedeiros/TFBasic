# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
}

# Internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Public Route Table
resource "aws_route_table" "main_public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

# DMZ
resource "aws_subnet" "top" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.top_cidr_block
}

# Route Table Assoc for DMZ
resource "aws_route_table_association" "top" {
  subnet_id      = aws_subnet.top.id
  route_table_id = aws_route_table.main_public.id
}

# DMZ
resource "aws_subnet" "bottom" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.bottom_cidr_block
  availability_zone_id = aws_subnet.top.availability_zone_id
}

# Route Table Assoc for DMZ
resource "aws_route_table_association" "bottom" {
  subnet_id      = aws_subnet.bottom.id
  route_table_id = aws_route_table.main_public.id
}
