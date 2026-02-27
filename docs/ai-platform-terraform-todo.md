# 📝 AI Platform Terraform TODO Checklist

> Friendly, step-by-step guide to deploy the AI platform using Terraform modules.  
> Follow one module at a time and mark ✅ when done.  

--- 
# 📌 High-Level Overview (Headers Only)
- [ ] 0️⃣ Bootstrap
- [ ] 1️⃣ Networking & Security
- [ ] 2️⃣ IAM Roles & Policies
- [ ] 3️⃣ Container Registry
- [ ] 4️⃣ ECS Cluster & Tasks
- [ ] 5️⃣ Load Balancing & Routing
- [ ] 6️⃣ API Gateway
- [ ] 7️⃣ Backend Lambda Functions
- [ ] 8️⃣ Bedrock AgentCore Runtime
- [ ] 9️⃣ CloudFront Distribution
- [ ] 🔟 CI/CD Pipeline

## 0️⃣ Bootstrap – `bootstrap/` (Before everything else)
- [ ] Manually configure AWS CLI / SSO locally (`aws configure`)  
- [ ] Create S3 bucket → Terraform remote state  
- [ ] Create DynamoDB table → Terraform state locking  
- [ ] Create initial IAM Role → for CI/CD / Terraform execution  # add inline permissions to CLI user

> 🔹 After this step, Terraform can manage the rest safely.

---

## 1️⃣ Networking & Security Roadmaps

This section provides two clear architecture paths for your AI platform project.  
Choose **Serverless (No VPC)** for simplicity or **Containers (With VPC)** for more control.

---

## 🟢 Roadmap A — Serverless (No VPC)

**Frontend:** S3 + CloudFront  
**Backend:** API Gateway + Lambda + DynamoDB  

- 📦 Simpler  
- 💲 Cheaper  
- ⚡ Faster to build  
- 📱 Mobile-ready immediately  

### Networking & Security – `modules/security` (No VPC)

- [ ] Create S3 bucket for frontend  
- [ ] Enable S3 block public access  
- [ ] Create CloudFront distribution  
- [ ] Create Origin Access Control (OAC)  
- [ ] Attach bucket policy for CloudFront only  
- [ ] Create API Gateway (public)  
- [ ] Create Lambda functions (NOT attached to VPC)  
- [ ] Create IAM execution roles for Lambda  
- [ ] Create Cognito (if using auth)  
- [ ] Enable HTTPS (ACM certificate for CloudFront)

**Notes:**  
- 🚫 No VPC  
- 🚫 No subnets  
- 🚫 No route tables  
- 🚫 No NAT  
- 🚫 No security groups (Lambda public mode doesn't use them)

**When to choose:**  
- MVP / solo dev  
- Mostly managed AWS services  
- No RDS / Redis  
- Lowest complexity

---

## 🔵 Roadmap B — Containers (With VPC)

**Frontend or backend on ECS/Fargate**  

- 📦 More control  
- 🧠 More complex  
- 💲 Slightly higher cost  
- 🛠 Required for RDS / Redis / internal services  

### Networking & Security – `modules/networking`

- [ ] Create VPC  
- [ ] Create 2 public subnets (2 AZs)  
- [ ] Create 2 private subnets (2 AZs)  
- [ ] Create Internet Gateway (IGW)  
- [ ] Create route tables  
- [ ] Associate public subnets with IGW  
- [ ] Create NAT Gateway (for private subnet outbound access)  
- [ ] Associate private subnets with NAT  
- [ ] Create security groups for:
  - ECS services
  - ALB
  - Lambda (if attached to VPC)
  - RDS (if used)

### ECS Layer

- [ ] Create ECS cluster  
- [ ] Create task definitions  
- [ ] Create ECS services  
- [ ] Create Application Load Balancer  
- [ ] Attach ALB security group  
- [ ] Attach target groups  

**When to choose:**  
- Long-running AI workloads  
- Heavy compute / microservices  
- RDS database / internal-only services  

---

## 🔥 Strategic Recommendation

For a **solo dev AI wellness app**:

- Start with **Roadmap A (No VPC)**  
- Keep modular design so you can later move heavy compute to ECS without rewriting everything  

---

## 🧠 Evolution Path

1. Stage 1 → Serverless MVP  
2. Stage 2 → Add SQS + background Lambda  
3. Stage 3 → Move heavy AI workers to ECS  
4. Stage 4 → Introduce VPC only when needed  

---

## 2️⃣ IAM Roles & Policies – `modules/iam`
- [ ] ECS Task Execution Role → allow ECS to pull images + write logs  
- [ ] Lambda Execution Role → allow Lambda to access AWS services  
- [ ] Bedrock Agent IAM Role → allow AgentCore runtime to run  
- [ ] CodeBuild Role → allow build + push to ECR  
- [ ] CodeDeploy Role → allow deployment of ECS tasks  
- [ ] Policies for ECR access (frontend + agentcore repos)  

---

## 3️⃣ Container Registry – `modules/ecr`
- [ ] Create ECR repository for frontend  
- [ ] Create ECR repository for agentcore  

---

## 4️⃣ ECS Cluster & Tasks – `modules/ecs`
- [ ] Create ECS cluster (Fargate)  
- [ ] Create ECS task definitions (frontend + agentcore)  
- [ ] Create ECS services (frontend + agentcore)  

---

## 5️⃣ Load Balancing & Routing – `modules/alb`
- [ ] Create Application Load Balancer (ALB)  
- [ ] Create target groups for ECS services  
- [ ] Configure listener rules → route `/api/*` to Lambda or ECS  

---

## 6️⃣ API Gateway – `modules/api-gateway`
- [ ] Create HTTP API  
- [ ] Create routes (`/api/*`) pointing to Lambda functions  
- [ ] Configure CORS and security  

---

## 7️⃣ Backend Lambda Functions – `modules/lambda`
- [ ] Create Lambda function(s)  
- [ ] Set environment variables (Bedrock info, secrets)  
- [ ] Enable CloudWatch logging for monitoring  

---

## 8️⃣ Bedrock AgentCore Runtime – `modules/bedrock-agent`
- [ ] Deploy AgentCore container to ECS  
- [ ] Attach Bedrock IAM role  
- [ ] Test Lambda → AgentCore communication  

---

## 9️⃣ CloudFront Distribution – `modules/cloudfront`
- [ ] Create CloudFront distribution  
- [ ] Point to ALB or S3 (frontend)  
- [ ] Enable HTTPS/TLS  
- [ ] Configure caching & behaviors  

---

## 🔟 CI/CD Pipeline – outside Terraform
- [ ] Create CodePipeline  
- [ ] Add stages: Source → Build → Deploy  
- [ ] Configure CodeBuild with `buildspec.yml`  
- [ ] Configure CodeDeploy with `appspec.yaml`  
- [ ] Test full end-to-end deployment  

---

## ✅ Tips
- Focus **one module at a time** → mark ✅ when done  
- Use **outputs from previous module** as input for next  
- Comment resources in `main.tf` → helps recall later  
- Keep environment configs separate: dev, staging, prod  
- Plan → Apply → Test each module  

---
