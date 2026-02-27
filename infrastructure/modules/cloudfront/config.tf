# CloudFront Origin Access Control
resource "aws_cloudfront_origin_access_control" "frontend_oac" {
  name                              = "S3-${var.s3_frontend_bucket_resource.id}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"

}

 # CloudFront distribution
 resource "aws_cloudfront_distribution" "frontend_distro" {
    # enabled (Required) - Whether the distribution is enabled to accept end user requests for content.
   enabled = true
   default_root_object = "frontend/site/index.html"

   # Create CloudFront distribution pointing to your S3 bucket
   origin {
    domain_name                 = var.s3_frontend_bucket_resource.bucket_regional_domain_name
    origin_access_control_id    = aws_cloudfront_origin_access_control.frontend_oac.id
    origin_id                   = var.s3_frontend_bucket_resource.id
   }

    #  At least 1 "default_cache_behavior" blocks are required.
    # AWS Managed Caching Policy (Managed-CachingOptimized)
    default_cache_behavior {
        # Using the Managed-CachingOptimized managed policy ID:
        cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        allowed_methods        = ["GET", "HEAD", "OPTIONS"]
        cached_methods         = ["GET", "HEAD"]
        target_origin_id       = var.s3_frontend_bucket_resource.id
        viewer_protocol_policy = "allow-all"
    }

  # At least 1 "restrictions" blocks are required.
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US"]
    }
  }

   viewer_certificate {
     cloudfront_default_certificate = true
   }
 
   tags = {
     Env = var.environment
   }
 }

# See https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html
data "aws_iam_policy_document" "s3_origin_iam_policy" {
  statement {
    sid    = "AllowCloudFrontServicePrincipalReadWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "${var.s3_frontend_bucket_resource.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.frontend_distro.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_origin_policy" {
  bucket = var.s3_frontend_bucket_resource.id
  policy = data.aws_iam_policy_document.s3_origin_iam_policy.json
}


