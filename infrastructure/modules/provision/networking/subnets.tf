# ---------------------------------------------------------
# Public Subnets
# ---------------------------------------------------------
# These subnets are associated with a route table that
# routes 0.0.0.0/0 to the Internet Gateway.
#
# Public subnets are ONLY for:
# - Application Load Balancers
# - Bastion hosts (if needed)
# - NAT Gateways
#
# DO NOT place databases or internal services here.
# Mixing public and private resources is the #1
# beginner networking mistake in AWS.
# ---------------------------------------------------------

#resource "aws_subnet" "main" {
#  vpc_id     = aws_terraform_vpc.terraform_main.id
#  cidr_block = "10.0.1.0/24"
#
#  tags = {
#    Name = "Main"
#  }
#}