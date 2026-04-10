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
# Create a dev VPC 
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

resource "aws_subnet" "dev-public-1" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1"
  map_public_ip_on_launch = false

  tags = {
    Name        = "dev-public-1"
    environment = "dev"
  }
}