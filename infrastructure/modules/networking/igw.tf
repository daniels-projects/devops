# resource "aws_internet_gateway" "agent_frontend_gw" {
#   vpc_id = aws_terraform_vpc.terraform_main.id
# 
#   tags = {
#     Name = "main"
#   }
# }