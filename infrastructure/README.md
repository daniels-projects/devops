# 🏗 AI Platform Terraform Blueprint

> Friendly, step-by-step Terraform guide for building your AI Chat Platform from scratch.

---

## 📑 Table of Contents

1. [Overview](#overview)  
2. [Folder & Module Structure](#folder--module-structure)  
3. [Step-by-Step Module Deployment](#step-by-step-module-deployment)  
4. [Tips & Best Practices](#tips--best-practices)  

---

## Overview

This Terraform project is designed to **provision all resources** needed for the AI platform:

- Networking & Security  
- IAM Roles & Policies  
- Container Repositories (ECR)  
- ECS Cluster & Tasks  
- ALB & Routing  
- API Gateway  
- Lambda Functions  
- Bedrock AgentCore Runtime  
- CloudFront Distribution  

> Each module is **independent**, so you can **focus on one at a time**.  

---

# 🗂 Terraform Folder & File Best Practices

> Simple explanation for Terraform modules and folder structure.

---

## 1️⃣ Why modules have `main.tf`, `variables.tf`, `outputs.tf`

| File           | Purpose                                                      |
|----------------|--------------------------------------------------------------|
| `main.tf`      | Contains the actual resources for that module (e.g., VPC, ECS, ALB) |
| `variables.tf` | Defines inputs that can be customized (e.g., CIDR, names, sizes) |
| `outputs.tf`   | Defines outputs other modules or environments need (e.g., VPC ID, subnet IDs) |
| `provider.tf`  | “Where am I deploying?”
| main.tf (root) | “What am I deploying (global)?”

> ✅ Keeping these files separate is **best practice** for clean, reusable, and scalable modules.

infrastructure/
├── README.md                    # Explains module structure and step-by-step workflow
├── main.tf                      # Root entry point calling modules (optional, can be in environment folders)
├── variables.tf                 # Global variables
├── outputs.tf                   # Global outputs
├── providers.tf                 # AWS provider configuration
├── modules/                     # Reusable building blocks
│   ├── networking/              # VPC, subnets, route tables, IGW, NAT, security groups
|   |    ├── subnets.tf
|   |    ├── igw.tf
|   |    ├── route_tables.tf
│   │    └── outputs.tf
│   ├── iam/                      # IAM roles and policies
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ecr/                      # ECR repositories for frontend and agentcore
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ecs/                      # ECS cluster, task definitions, services
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── alb/                      # ALB, target groups, listeners
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── api-gateway/              # HTTP API routes
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── lambda/                   # Backend Lambda functions
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── bedrock-agent/            # ECS service for AI AgentCore runtime
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── cloudfront/               # CloudFront distribution for frontend
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/                 # Environment-specific configs
    ├── dev/
    │   ├── main.tf               # Calls modules with dev variables
    │   └── terraform.tfvars
    ├── staging/
    │   ├── main.tf
    │   └── terraform.tfvars
    └── prod/
        ├── main.tf
        └── terraform.tfvars

---

## 2️⃣ Why this is production-level

- Modules are **self-contained**, easy to reuse across environments  
- Variables and outputs make **dependency management clean**  
- Multi-environment setup (dev/staging/prod) is supported  

> This structure is **slightly verbose**, but ideal for production or team projects.

---
## 3 Summary

- **Production recommendation:** Keep `main.tf / variables.tf / outputs.tf` per module  
- **Optional simplifications:** Merge files or flatten small modules  
- Goal: **Clean, reusable, scalable, and easy to follow**

---

## Step-by-Step Module Deployment

Follow this order. **One module at a time**. ✅ check off when done.

### 1️⃣ Networking & Security (Foundation)
- `modules/networking`  
- Create VPC, subnets, route tables, IGW, NAT, security groups  

### 2️⃣ IAM Roles & Policies
- `modules/iam`  
- ECS/Lambda/Bedrock roles  
- CodeBuild/CodeDeploy roles  
- Policies for ECR access  

### 3️⃣ Container Registry
- `modules/ecr`  
- ECR repos for frontend + agentcore  

### 4️⃣ ECS Cluster & Tasks
- `modules/ecs`  
- ECS cluster (Fargate)  
- Task definitions & services (frontend + agent)  

### 5️⃣ Load Balancing & Routing
- `modules/alb`  
- ALB, target groups, listener rules  

### 6️⃣ API Gateway
- `modules/api-gateway`  
- HTTP API routes (`/api/*`) → Lambda functions  

### 7️⃣ Backend Lambda Functions
- `modules/lambda`  
- Create Lambda functions, set env variables, enable logging  

### 8️⃣ Bedrock AgentCore Runtime
- `modules/bedrock-agent`  
- ECS service for agentcore  
- Attach Bedrock IAM role  
- Test Lambda → AgentCore integration  

### 9️⃣ CloudFront Distribution
- `modules/cloudfront`  
- Point to ALB or S3 (frontend)  
- Enable HTTPS/TLS  

### 10️⃣ CI/CD Pipeline
- Setup CodePipeline (outside Terraform)  
- CodeBuild → buildspec.yml  
- CodeDeploy → appspec.yaml  
- Trigger deployments automatically  

---

## Tips & Best Practices

- **Focus on one module at a time** → less overwhelming  
- **Test after each module** (`terraform plan` → `terraform apply`)  
- **Use outputs from one module as input** to the next (VPC ID, subnet IDs, security group IDs)  
- Keep **variables organized** in `terraform.tfvars` per environment  
- **Comment each resource** in `main.tf` — explain what it does  
- Use **separate environments** (dev, staging, prod)  
- Keep Terraform code **small, modular, and reusable**  

---

> ✅ This guide lets you go from **empty AWS account → fully running AI platform** without getting overwhelmed.  
> Step by step, one module at a time.

---

## Resources
| Resource                | Terraform Doc                                                                                                                                                                                              | What You Learn                              |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| VPC                     | [https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)                                         | Define CIDR, tags, default settings         |
| Subnet                  | [https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                   | AZs, CIDR blocks, public/private            |
| Internet Gateway        | [https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)               | Attach to VPC, allow internet traffic       |
| Route Table             | [https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)                         | Add routes, associate subnets               |
| Security Group          | [https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                   | Inbound/outbound rules, attach to resources |
| Route Table Association | [https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | Link route table → subnet                   |

---