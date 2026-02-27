# ---------------------------------------------------------
# Public Route Table
# ---------------------------------------------------------
# Any subnet associated with this route table is PUBLIC.
# It contains a default route (0.0.0.0/0) pointing to
# the Internet Gateway.
#
# If a resource is placed in a subnet using this route table,
# it is internet-reachable (depending on security groups).
# ---------------------------------------------------------
# resource "aws_route_table" "main" {
#   vpc_id = aws_terraform_vpc.example.id
# 
#   route {
#     cidr_block = "10.0.1.0/24"
#     gateway_id = aws_internet_gateway.agent_frontend_gw.id
#   }
# 
#   tags = {
#     Name = "example"
#   }
# }