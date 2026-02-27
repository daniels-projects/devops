# -------------------------------------------------
# Terraform Backend
# Tells Terraform where to store remote state
# Must point to S3 bucket + DynamoDB that already exist
#
# | Tool      | Purpose                  | Analogy                 |
# | --------- | ------------------------ | ----------------------- |
# | S3 Bucket | Stores Terraform state   | Terraform’s brain       |
# | DynamoDB  | Locks state during apply | Seatbelt for your brain |
#
# -------------------------------------------------
terraform {
  backend "s3" {
    bucket         = "this-ismy-terraform-state-unique-name"  # created in bootstrap
    key            = "prod/terraform.tfstate"
    region         = "us-west-2" # Backend config is evaluated before variables exist.
    dynamodb_table = "terraform-locks"    # created in bootstrap
    encrypt        = true
  }
}