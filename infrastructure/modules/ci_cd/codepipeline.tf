# GitHub
#    ↓
# CodePipeline (Source)
#    ↓
# S3 Deploy Action

resource "aws_codepipeline" "frontend_pipeline" {
  name     = "frontend-pipeline"
  role_arn = var.pipeline_role_arn  # IAM Role created previously

  artifact_store {
    type     = "S3"
    location = var.pipeline_artifacts_bucket.id # Bucket for intermediate artifacts
  }

  stage {
    name = "Source"
    action {
      name             = "GitHub_Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.codestar_github_connection_arn
        FullRepositoryId = "${var.github_owner}/${var.github_repo}"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "DeployToS3"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      version         = "1"
      input_artifacts = ["source_output"]

      configuration = {
        BucketName = var.s3_frontend_bucket_resource.id  # Bucket to host static site
        Extract    = "true"                  # Unzip artifact
      }
    }
  }
}

# TODO:
# -------------------------------
# Optional: Webhook to auto-trigger pipeline
# -------------------------------
# resource "aws_codepipeline_webhook" "github_webhook" {
#   name            = "frontend-pipeline-webhook"
#   target_action   = "GitHub_Source"
#   target_pipeline = aws_codepipeline.frontend_pipeline.name
#   authentication  = "GITHUB_HMAC"
#   authentication_configuration {
#     secret_token = var.github_webhook_secret
#   }
# 
#   filter {
#     json_path    = "$.ref"
#     match_equals = "refs/heads/${var.github_branch}"
#   }
# }