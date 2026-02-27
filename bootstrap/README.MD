# 📝  Platform Terraform Bootstrap Checklist

> Minimal setup to get Terraform running for your platform.  
> One step at a time. ✅ when done.

project-root/
├── bootstrap/        ← Terraform Project #1
└── infrastructure/   ← Terraform Project #2

bootstrap/
├── main.tf        ← can be empty or have bootstrap resources
├── providers.tf   ← AWS provider config
└── versions.tf    ← required_providers + Terraform version
---

## 0️⃣ Create Minimal IAM Roles (Manual via GUI)

- [ ] Create a **Bootstrap IAM Role**  
  - Purpose: Terraform can create backend resources (S3 + DynamoDB) and future IAM roles  
  - Permissions: S3 (create bucket + versioning + encryption), DynamoDB (create table), IAM (create role, attach policy, pass role)  
  - Trust: your local dev user or CI/CD pipeline  
- [ ] Test that you can assume this role via AWS CLI  

> These roles are **minimal**, no AdminAccess needed.

---

## 1️⃣ Run Bootstrap (Locally)

1. Authenticate AWS CLI:  
   ```bash
   aws configure
   ```

2. Navigate to bootstrap folder:
    ```
    cd bootstrap 
    ```

3. Initialize Terraform:
    ```
    terraform init
    ```

4. Apply bootstrap resources:
    ```
    terraform apply
    ```

## 2️⃣ What Does “Bootstrap” Mean?
- Bootstrap = first setup step that enables everything else
- Minimal manual setup so automation can take over
- Analogy: starting a car
    - You turn the key once → engine runs itself
    - After bootstrap, Terraform can create all remaining infrastructure automatically

✅ Notes / Tips
- Focus on one thing at a time: IAM role → backend
- After bootstrap, all other modules (networking, ECS, Lambda, etc.) can be fully Terraform-managed
- Keep your bootstrap role minimal and secure — avoid giving full AdminAccess