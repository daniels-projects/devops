# 📝 AI Platform Resource TODO Checklist

> Simple step-by-step guide to creating your AI platform resources.  
> One task at a time. ✅ when done.

---

## ✅ Step-by-Step Checklist

### 1. Networking & Security
- [ ] Create VPC  
- [ ] Create subnets (public + private)  
- [ ] Create route tables + internet gateway  
- [ ] Create NAT gateway (if private subnets need internet)  
- [ ] Create security groups (ECS, ALB, Lambda, API Gateway)  

---

### 2. IAM Roles & Policies
- [ ] ECS Task Execution Role  
- [ ] Lambda Execution Role  
- [ ] Bedrock Agent IAM Role  
- [ ] CodeBuild Role  
- [ ] CodeDeploy Role  
- [ ] Policies for ECR access  

---

### 3. Container Registry
- [ ] Create ECR repository for frontend  
- [ ] Create ECR repository for agentcore  

---

### 4. Compute Platform (ECS Cluster)
- [ ] Create ECS cluster (Fargate recommended)  
- [ ] Create ECS task definitions (frontend + agent)  
- [ ] Create ECS services (frontend + agent)  

---

### 5. Load Balancing & Routing
- [ ] Create ALB (Application Load Balancer)  
- [ ] Create target groups for ECS services  
- [ ] Configure listener rules (route traffic to frontend service)  

---

### 6. API Gateway
- [ ] Create HTTP API (API Gateway)  
- [ ] Create routes (`/api/*`) → Lambda functions  

---

### 7. Backend AI Lambda Functions
- [ ] Create Lambda function(s)  
- [ ] Set environment variables (Bedrock Agent info, secrets)  
- [ ] Enable CloudWatch logging  

---

### 8. Bedrock AgentCore Runtime
- [ ] Deploy AgentCore container to ECS  
- [ ] Attach Bedrock IAM role  
- [ ] Test Lambda → AgentCore communication  

---

### 9. Content Delivery & Edge Caching
- [ ] Create CloudFront distribution  
- [ ] Point to ALB or S3 (frontend)  
- [ ] Enable HTTPS/TLS  

---

### 10. CI/CD Pipeline
- [ ] Create CodePipeline  
- [ ] Add stages: Source → Build → Deploy  
- [ ] Configure CodeBuild with buildspec.yml  
- [ ] Configure CodeDeploy with appspec.yaml  
- [ ] Test deployment end-to-end  

---

> ✅ Tip: Focus on **one task at a time**.  
> Mark it done ✅ before moving to the next.  
> This is your **roadmap from empty AWS account → fully running AI platform**.
