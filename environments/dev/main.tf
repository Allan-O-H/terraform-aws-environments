# ========================================
# Terraform & Provider Configuration for Dev Environment
# ========================================
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

## DEV VPC 
resource "aws_vpc" "dev-vpc" {
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
resource "aws_subnet" "dev-private-1" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1"
  map_public_ip_on_launch = false

  tags = {
    Name        = "dev-private-1"
    environment = "dev"
  }
}

# Public Subnets
resource "aws_subnet" "dev-public-1" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1"
  map_public_ip_on_launch = true

  tags = {
    Name        = "dev-public-1"
    environment = "dev"
  }
}

# ========================================================
## Prod VPC
resource "aws_vpc" "prod-vpc" {
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
resource "aws_subnet" "prod-private-1" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "us-east-1"
  map_public_ip_on_launch = false

  tags = {
    Name        = "prod-private-1"
    environment = "prod"
  }
}

# Public Subnets
resource "aws_subnet" "prod-public-1" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "us-east-1"
  map_public_ip_on_launch = true

  tags = {
    Name        = "prod-public-1"
    environment = "prod"
  }
}