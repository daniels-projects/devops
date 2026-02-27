# ---------------------------------------------------------
# Security Groups
# ---------------------------------------------------------
# Security Groups act as virtual firewalls.
#
# Public-facing resources (ALB) may allow:
# - HTTP (80)
# - HTTPS (443)
#
# Backend services should only allow inbound traffic
# from the ALB security group, NOT from 0.0.0.0/0.
#
# Never use wide-open rules unless absolutely necessary.
# ---------------------------------------------------------
