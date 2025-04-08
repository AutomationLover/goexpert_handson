provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

# VPC 1 Configuration
resource "aws_vpc" "vpc1" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "VPC1" }
}

resource "aws_subnet" "vpc1_public" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = { Name = "VPC1-Public-Subnet" }
}

resource "aws_internet_gateway" "vpc1_igw" {
  vpc_id = aws_vpc.vpc1.id
  tags = { Name = "VPC1-IGW" }
}

resource "aws_route_table" "vpc1_public_rt" {
  vpc_id = aws_vpc.vpc1.id
  tags = { Name = "VPC1-Public-RT" }
}

resource "aws_route" "vpc1_default" {
  route_table_id         = aws_route_table.vpc1_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc1_igw.id
}

resource "aws_route_table_association" "vpc1_rta" {
  subnet_id      = aws_subnet.vpc1_public.id
  route_table_id = aws_route_table.vpc1_public_rt.id
}

# VPC 2 Configuration
resource "aws_vpc" "vpc2" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "VPC2" }
}

resource "aws_subnet" "vpc2_public" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = { Name = "VPC2-Public-Subnet" }
}

resource "aws_internet_gateway" "vpc2_igw" {
  vpc_id = aws_vpc.vpc2.id
  tags = { Name = "VPC2-IGW" }
}

resource "aws_route_table" "vpc2_public_rt" {
  vpc_id = aws_vpc.vpc2.id
  tags = { Name = "VPC2-Public-RT" }
}

resource "aws_route" "vpc2_default" {
  route_table_id         = aws_route_table.vpc2_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc2_igw.id
}

resource "aws_route_table_association" "vpc2_rta" {
  subnet_id      = aws_subnet.vpc2_public.id
  route_table_id = aws_route_table.vpc2_public_rt.id
}

# Transit Gateway Configuration
resource "aws_ec2_transit_gateway" "tgw" {
  description = "TGW for VPC peering"
  tags = { Name = "Main-TGW" }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1_attachment" {
  subnet_ids         = [aws_subnet.vpc1_public.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.vpc1.id
  tags = { Name = "VPC1-Attachment" }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc2_attachment" {
  subnet_ids         = [aws_subnet.vpc2_public.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.vpc2.id
  tags = { Name = "VPC2-Attachment" }
}

# Cross-VPC Routing
resource "aws_route" "vpc1_to_vpc2" {
  route_table_id         = aws_route_table.vpc1_public_rt.id
  destination_cidr_block = aws_vpc.vpc2.cidr_block
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "vpc2_to_vpc1" {
  route_table_id         = aws_route_table.vpc2_public_rt.id
  destination_cidr_block = aws_vpc.vpc1.cidr_block
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}
