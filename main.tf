# ========================================
# Terraform & Provider Configuration
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

