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

# ========================================
# Networking - VPC & cidr range
# ========================================
# Create a dev VPC with specified CIDR range
resource "aws_vpc" "dev-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name        = "dev"
    enviornment = "dev"
  }
}