# ======================================================
# Terraform & Provider Configuration for Dev Environment
# ======================================================
# Configure required Terraform version and Azure provider (aws)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# ========================================================
# Networking - VPC, Subnets, NAT Gateway, Internet Gateway
# ========================================================
### DEV VPC 
resource "aws_vpc" "dev_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "dev"
    enviornment = "dev"
  }
}

# Private Subnets
resource "aws_subnet" "dev_private_1" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1"
  map_public_ip_on_launch = false

  tags = {
    Name        = "dev_private_1"
    environment = "dev"
  }
}

# Public Subnets
resource "aws_subnet" "dev_public_1" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1"
  map_public_ip_on_launch = true

  tags = {
    Name        = "dev_public_1"
    environment = "dev"
  }
}

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "dev_igw"
    environment = "dev"
  }
}

resource "aws_route_table" "dev_public_rt" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }

  tags = {
    Name        = "dev_public_rt"
    environment = "dev"
  }
}

resource "aws_rout_table_association" "dev_public_rt_a" {
  subnet_id = aws_subnet.dev_public_1.id
  route_table_id = aws_route_table.dev_public_rt.id
}

# ========================================================
## Prod VPC
resource "aws_vpc" "prod_vpc" {
  cidr_block           = "10.1.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "prod"
    enviornment = "prod"
  }
}

# Private Subnets
resource "aws_subnet" "prod_private_1" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "us-east-1"
  map_public_ip_on_launch = false

  tags = {
    Name        = "prod_private_1"
    environment = "prod"
  }
}

# Public Subnets
resource "aws_subnet" "prod_public_1" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "us-east-1"
  map_public_ip_on_launch = true

  tags = {
    Name        = "prod_public_1"
    environment = "prod"
  }
}


