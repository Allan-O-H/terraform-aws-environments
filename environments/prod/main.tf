# ========================================
# Terraform & Provider Configuration for PROD Environment
# ========================================
# Configure required Terraform version and AWS provider  
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
# Networking - PROD VPC
# ========================================================
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