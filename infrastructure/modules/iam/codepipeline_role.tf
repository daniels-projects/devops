# CodePipeline Role
resource "aws_iam_role" "codepipeline_role" {
  name = "frontend-codepipeline-role"

  # Trust policy: CodePipeline can assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Environment = var.environment
  }
}

# Attach a managed policy for S3 + Code access
resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "frontend-codepipeline-policy"
  role = aws_iam_role.codepipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Allow CodeStar Connections UseConnection
      {
        Effect = "Allow"
        Action = [
          "codeconnections:UseConnection",
          "codestar-connections:UseConnection"
        ]
        Resource = var.codestar_github_connection_arn # You can scope to specific build projects for least privilege
      },
      # Allow CodePipeline to start CodeBuild projects
      {
        Effect = "Allow"
        Action = [
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds"
        ]
        Resource = "*" # You can scope to specific build projects for least privilege
      },
      # Allow CodePipeline to read/write S3 artifacts
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.s3_frontend_bucket_resource.id}/",       # bucket itself
          "arn:aws:s3:::${var.s3_frontend_bucket_resource.id}/*",       # bucket objects
          "arn:aws:s3:::${var.pipeline_artifacts_bucket.id}/"      # objects
          "arn:aws:s3:::${var.pipeline_artifacts_bucket.id}/*"      # objects
        ]
      }
    ]
  })
}