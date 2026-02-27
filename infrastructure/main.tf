module "frontend" {
  source = "./modules/storage/frontend"

  # Pass from root variable
  environment = var.environment
  s3_frontend_bucket_name = var.s3_frontend_bucket_name

  }


module "cloudfront" {
  source = "./modules/cloudfront"

  environment = var.environment
  s3_frontend_bucket_resource =  module.frontend.s3_frontend_bucket_resource
 
}

module "codestar" {
  source = "./modules/integrations/github"
}

module "iam" {
  source = "./modules/iam"

  environment = var.environment
  s3_frontend_bucket_resource =  module.frontend.s3_frontend_bucket_resource
  pipeline_artifacts_bucket = module.cicd.pipeline_artifacts_bucket
  codestar_github_connection_arn = module.codestar.github_connection_arn

}

module "cicd" {
  source = "./modules/ci_cd"

  s3_frontend_bucket_resource =  module.frontend.s3_frontend_bucket_resource
  pipeline_role_arn = module.iam.codepipeline_role_arn
  pipeline_artifacts_bucket = module.cicd.pipeline_artifacts_bucket

  codestar_github_connection_arn = module.codestar.github_connection_arn
  github_owner = var.github_owner
  github_repo = var.github_repo
}

