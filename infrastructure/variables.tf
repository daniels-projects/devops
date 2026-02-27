variable "aws_region" {
  description = "AWS Region for the VPC"
  type        = string
  default     = "us-west-2"
}

variable "s3_frontend_bucket_name" {
  description = "s3 Bucket for frontend"
  type        = string
  default     = "my-unique-s3-frontend-bucket"
}

variable "environment" {
  default = "dev"
}

variable "github_owner" {
  default   = "daniels-projects"
}

variable "github_repo" {
  default   = "devops"
}