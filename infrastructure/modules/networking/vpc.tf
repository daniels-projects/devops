# ---------------------------------------------------------
# VPC Configuration
# ---------------------------------------------------------
# This VPC is designed for small multi-client deployments.
# We use a /16 CIDR to allow future subnet expansion.
# DNS support and hostnames must be enabled for:
# - ALB DNS resolution
# - ECS service discovery
# - Public-facing services
#
# IMPORTANT:
# Do NOT attach public-facing and private resources
# to the same subnet. Public and private tiers
# must remain logically separated.
#
# ---------------------------------------------------------

resource "aws_vpc" "terraform_main" {
  cidr_block       = "10.0.0.0/16"
  region = var.aws_region 
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}

