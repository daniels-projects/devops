resource "aws_s3_bucket" "my_pipeline_artifcat_bucket" {
  bucket = "thismyuniquetest-example-pipeline-artifacts"

  force_destroy = true
}

resource "aws_s3_bucket_versioning" "artifact" {
  bucket = aws_s3_bucket.my_pipeline_artifcat_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "myunique_pipeline_artifcat_sse" {
  bucket = aws_s3_bucket.my_pipeline_artifcat_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}