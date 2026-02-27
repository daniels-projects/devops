# Create S3 bucket
resource "aws_s3_bucket" "frontend" {
bucket = var.s3_frontend_bucket_name

 tags = {
    Name = var.s3_frontend_bucket_name
    Env  = var.environment
  }
}

# Set bucket object ownership
resource "aws_s3_bucket_ownership_controls" "bucket_owner_preferred" {
  bucket = aws_s3_bucket.frontend.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "block_pub_access" {
  bucket = aws_s3_bucket.frontend.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
 
}

# Enable **versioning** (recommended)
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.frontend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_cors_configuration" "frontend_cors" {
  bucket = aws_s3_bucket.frontend.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
  }

}

# resource "aws_s3_bucket_website_configuration" "fontend_website_conf" {
#   bucket = aws_s3_bucket.frontend.id
# 
#   index_document {
#     suffix = "index.html"
#   }
# 
#   error_document {
#     key = "error.html"
#   }
# }