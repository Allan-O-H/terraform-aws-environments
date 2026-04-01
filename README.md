# Terraform AWS Dev & PROD Environment

## Overview

This project provisions reproducible **Development** and **Production** environments in AWS using Terraform.  
The goal is to model a small but realistic cloud platform with separate dev/prod environments, including VPC networking, compute, IAM, and basic monitoring/logging, in a way that reflects enterprise cloud engineering practices.

It is designed as a learning and portfolio project to demonstrate infrastructure as code, multi‑environment design, and an operational mindset suitable for a Cloud Engineer role.


## Architecture

High level overview of the Terraform project:

    - One AWS account used for the project
    - Two seperate environments:
        - **Development VPC**
        - ** Production VPC**
    - Each Environment contains:
        - **Public** and **Private** subnets
        - An **INternet Gateway** for outbound/inbound internet access to public resources
        - **NAT Gateway** to allow private resources to connect to the internet without being directly exposed
        - One **EC2 instance** acting as the primary workload for the environment

```text
AWS Account
  ├── DEV Environment
  │     ├── DEV VPC
  │     │     ├── Public Subnet(s)  -> Internet via IGW
  │     │     ├── Private Subnet(s) -> Internet via NAT
  │     │     └── EC2 workload
  │     └── IAM roles for dev operations
  └── PROD Environment
        ├── PROD VPC
        │     ├── Public Subnet(s)  -> Internet via IGW
        │     ├── Private Subnet(s) -> Internet via NAT
        │     └── EC2 workload
        └── IAM roles for prod operations