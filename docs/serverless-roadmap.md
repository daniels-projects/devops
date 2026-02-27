# 🟢 Serverless Frontend Deployment Checklist (AWS CodePipeline + S3 + CloudFront)

> Step-by-step guide for deploying a static frontend from GitHub to AWS using CodePipeline.  
> Minimal resources, no VPC needed.

---

## 0️⃣ Prerequisites / Bootstrap
- [x] Terraform state S3 + DynamoDB configured (already done)
- [x] AWS CLI configured locally (aws configure)
- [x] IAM user with minimal permissions for initial setup (optional if using roles)

---

## 1️⃣ S3 Bucket (Frontend Hosting)
- [x] Create S3 bucket for frontend
  - Enable **private bucket** (block public access)
  - Enable **versioning** (recommended)
- [x] Note bucket name → will be used in CodePipeline / CodeBuild
- configure CORS
- [x] (Optional) Enable static website hosting if CloudFront not used # We are using CloudFront

---

## 2️⃣ CloudFront Distribution (Optional but Recommended)
- [x] Create CloudFront distribution pointing to your S3 bucket
  - Origin = S3 bucket
  - Enable **Origin Access Control (OAC)** → restrict direct S3 access
  - create IAM poliy
  - Enable HTTPS / default CloudFront certificate (or ACM custom domain)
- [ ] Note distribution ID → needed for cache invalidation in pipeline
  - ToDO: create inline policy with all permissions needed


---

## 3️⃣ IAM Roles (Pipeline Permissions)
- [x] **CodePipeline role**
  - Permissions to orchestrate CodeBuild + S3 deployment
- [x] **CodeBuild role**
  - Permissions: `s3:PutObject`, `s3:ListBucket`, `cloudfront:CreateInvalidation` (if using CloudFront)
- [x] Ensure least privilege → no admin unless necessary

---

## 4️⃣ CodePipeline (CI/CD)
- [x] Create CodePipeline:
  - **Source stage** → GitHub repository (branch = main)
  - **Build stage** → CodeBuild # Not needed since were hosting ite on s#
  - **Deploy stage** → S3 bucket
- [ ] Configure webhook → triggers pipeline on GitHub push
- [ ] Assign pipeline role created above

---

## 5️⃣ CodeBuild Configuration
- [ ] Create `buildspec.yml` in GitHub repo:
```yaml
version: 0.2
phases:
  install:
    runtime-versions:
      nodejs: 18
    commands:
      - npm install
  build:
    commands:
      - npm run build
artifacts:
  files:
    - '**/*'
  base-directory: build
  discard-paths: yes