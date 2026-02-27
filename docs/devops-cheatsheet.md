# 🧩 AI Platform Cheat Sheet – Terraform + CI/CD + AWS

> One-page reference for building, deploying, and running your AI Chat Platform.

---

## 1️⃣ Terraform – Infrastructure as Code (IaC)
- **Purpose:** Creates AWS resources automatically  
- **What it builds:**  
  - VPC, subnets, security groups  
  - ECS cluster & task definitions  
  - ALB & target groups  
  - API Gateway, Lambda  
  - CloudFront distribution  
- **Analogy:** Terraform = builds the playground

---

## 2️⃣ Docker – Containers
- **Purpose:** Package apps into self-contained images  
- **Used for:** Frontend web app, AgentCore runtime  
- **Benefit:** Consistent deployment environment  
- **Analogy:** Docker = packages the toy

---

## 3️⃣ AppSpec & BuildSpec
| File          | Purpose                                  | Runs in         |
|---------------|----------------------------------------|----------------|
| buildspec.yml | Defines **how to build** the app       | CodeBuild      |
| appspec.yaml  | Defines **how to deploy** the artifact | CodeDeploy     |

- **Flow:** BuildSpec → artifact → AppSpec → deploy to ECS/Lambda  
- **Analogy:** BuildSpec = makes the toy, AppSpec = puts the toy in the playground

---

## 4️⃣ AWS CI/CD
- **CodePipeline:** Orchestrates stages (source → build → deploy)  
- **CodeBuild:** Builds Docker images / Lambda packages using buildspec.yml  
- **CodeDeploy:** Deploys to ECS / Lambda using appspec.yaml  
- **Benefit:** Automated, repeatable, reliable deployment

---

## 5️⃣ AWS Services Overview
| Service         | Purpose                                   |
|----------------|-------------------------------------------|
| CloudFront      | CDN, edge caching, HTTPS                   |
| ALB             | Route traffic to ECS / API Gateway         |
| HTTP API        | Route frontend requests to Lambda          |
| ECS (Fargate)   | Runs frontend & agent containers           |
| Lambda          | Backend compute for API requests           |
| Bedrock Agent   | AI processing / agent runtime              |
| ECR             | Container image storage                     |

---

## 6️⃣ High-Level Flow

# 🧩 AI Platform Cheat Sheet – Terraform + CI/CD + AWS

> One-page reference for building, deploying, and running your AI Chat Platform.

---

## 1️⃣ Terraform – Infrastructure as Code (IaC)
- **Purpose:** Creates AWS resources automatically  
- **What it builds:**  
  - VPC, subnets, security groups  
  - ECS cluster & task definitions  
  - ALB & target groups  
  - API Gateway, Lambda  
  - CloudFront distribution  
- **Analogy:** Terraform = builds the playground

---

## 2️⃣ Docker – Containers
- **Purpose:** Package apps into self-contained images  
- **Used for:** Frontend web app, AgentCore runtime  
- **Benefit:** Consistent deployment environment  
- **Analogy:** Docker = packages the toy

---

## 3️⃣ AppSpec & BuildSpec
| File          | Purpose                                  | Runs in         |
|---------------|----------------------------------------|----------------|
| buildspec.yml | Defines **how to build** the app       | CodeBuild      |
| appspec.yaml  | Defines **how to deploy** the artifact | CodeDeploy     |

- **Flow:** BuildSpec → artifact → AppSpec → deploy to ECS/Lambda  
- **Analogy:** BuildSpec = makes the toy, AppSpec = puts the toy in the playground

---

## 4️⃣ AWS CI/CD
- **CodePipeline:** Orchestrates stages (source → build → deploy)  
- **CodeBuild:** Builds Docker images / Lambda packages using buildspec.yml  
- **CodeDeploy:** Deploys to ECS / Lambda using appspec.yaml  
- **Benefit:** Automated, repeatable, reliable deployment

---

## 5️⃣ AWS Services Overview
| Service         | Purpose                                   |
|----------------|-------------------------------------------|
| CloudFront      | CDN, edge caching, HTTPS                   |
| ALB             | Route traffic to ECS / API Gateway         |
| HTTP API        | Route frontend requests to Lambda          |
| ECS (Fargate)   | Runs frontend & agent containers           |
| Lambda          | Backend compute for API requests           |
| Bedrock Agent   | AI processing / agent runtime              |
| ECR             | Container image storage                     |

---

## 6️⃣ High-Level Flow

Perfect — here’s a **one-page, ADHD/dyslexic-friendly cheat sheet** combining **Terraform, CI/CD, AppSpec, BuildSpec, and AWS services**.
Everything you need at a glance.

---

# docs/ai-platform-cheatsheet.md

```markdown
# 🧩 AI Platform Cheat Sheet – Terraform + CI/CD + AWS

> One-page reference for building, deploying, and running your AI Chat Platform.

---

## 1️⃣ Terraform – Infrastructure as Code (IaC) (more info /infrastructure/README)
- **Purpose:** Creates AWS resources automatically  
- **What it builds:**  
  - VPC, subnets, security groups  
  - ECS cluster & task definitions  
  - ALB & target groups  
  - API Gateway, Lambda  
  - CloudFront distribution  
- **Analogy:** Terraform = builds the playground

---

## 2️⃣ Docker – Containers
- **Purpose:** Package apps into self-contained images  
- **Used for:** Frontend web app, AgentCore runtime  
- **Benefit:** Consistent deployment environment  
- **Analogy:** Docker = packages the toy

---

## 3️⃣ AppSpec & BuildSpec
| File          | Purpose                                  | Runs in         |
|---------------|----------------------------------------|----------------|
| buildspec.yml | Defines **how to build** the app       | CodeBuild      |
| appspec.yaml  | Defines **how to deploy** the artifact | CodeDeploy     |

- **Flow:** BuildSpec → artifact → AppSpec → deploy to ECS/Lambda  
- **Analogy:** BuildSpec = makes the toy, AppSpec = puts the toy in the playground

---

## 4️⃣ AWS CI/CD
- **CodePipeline:** Orchestrates stages (source → build → deploy)  
- **CodeBuild:** Builds Docker images / Lambda packages using buildspec.yml  
- **CodeDeploy:** Deploys to ECS / Lambda using appspec.yaml  
- **Benefit:** Automated, repeatable, reliable deployment

---

## 5️⃣ AWS Services Overview
| Service         | Purpose                                   |
|----------------|-------------------------------------------|
| CloudFront      | CDN, edge caching, HTTPS                   |
| ALB             | Route traffic to ECS / API Gateway         |
| HTTP API        | Route frontend requests to Lambda          |
| ECS (Fargate)   | Runs frontend & agent containers           |
| Lambda          | Backend compute for API requests           |
| Bedrock Agent   | AI processing / agent runtime              |
| ECR             | Container image storage                     |

---

## 6️⃣ High-Level Flow

```

Terraform → builds infrastructure
↓
CodeBuild (buildspec.yml) → builds artifact
↓
ECR → stores Docker image
↓
CodeDeploy (appspec.yaml) → deploys to ECS / Lambda
↓
Frontend <-> API Gateway <-> Lambda <-> Bedrock Agent

```

---

## ✅ Quick Reference Tips
- Focus **on one module / stage at a time**  
- **Test before moving on**  
- Keep **variables & secrets separate per environment**  
- Comment all resources → easier to remember later  
- CI/CD ensures **automatic updates** after code changes  
- BuildSpec + AppSpec = **bridge between code and infrastructure**

---

This is **now a single-page “everything at a glance” cheat sheet**:

* Terraform modules → infrastructure
* Docker → containerized apps
* BuildSpec → builds artifacts
* AppSpec → deploys artifacts
* CodePipeline → CI/CD orchestration
* AWS services → runtime environment
* Flow diagram → easy visual memory

---
