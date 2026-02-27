# ============================================================
# 🔎 TL;DR — How Root Variables Work with Modules
#
# Modules CANNOT automatically access root variables.
# You must explicitly pass values from root → module.
#
# 3 Simple Steps:
#
# 1️⃣ Define variable in root (variables.tf)
#    variable "vpc_cidr" {}
#
# 2️⃣ Define same variable in module (modules/networking/variables.tf)
#    variable "vpc_cidr" {}
#
# 3️⃣ Pass it when calling the module (root main.tf)
#    module "networking" {
#      source   = "./modules/networking"
#      vpc_cidr = var.vpc_cidr
#    }
#
# Inside the module, use:
#    var.vpc_cidr
#
# 🧠 Mental Model:
# Root = Brain
# Module = Worker
# Brain must tell worker what to build.
*
#  Root variable
#  ↓
#  Passed into module block
#  ↓
#  Module variable receives it
#  ↓
#  Used inside module resource
#
#
# 🚨 Common Mistake:
# Trying to use var.project_name inside a module
# without passing it first → will fail.
# ============================================================

Generic Terraform Resource Template
# -------------------------------------------------
# Resource: <what this creates>
# Purpose : <why it exists in architecture>
# Depends : <what it attaches to or requires>
# Notes   : <important behavior / gotchas>
# -------------------------------------------------

resource "<PROVIDER>_<RESOURCE_TYPE>" "<NAME>" {
  
  # Required arguments
  required_argument = value

  # Optional arguments
  optional_argument = value

  # Tags (recommended for almost everything in AWS)
  tags = {
    Name        = "<resource-name>"
    Environment = var.environment
    Project     = var.project
  }
}

Examples:

# -------------------------------------------------
# Resource: VPC
# Purpose : Creates isolated network boundary
# Depends : None
# Notes   : Base container for subnets, IGW, etc.
# -------------------------------------------------

resource "aws_vpc" "my_main" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# -------------------------------------------------
# Resource: Internet Gateway (IGW)
# Purpose : Enables internet access for VPC
# Depends : VPC
# Notes   : Must be referenced in a route table
# -------------------------------------------------

resource "aws_internet_gateway" "custom_gw" {
  vpc_id = aws_vpc.my_main.id

  tags = {
    Name = "main-igw"
  }
}

Here’s a **simpler, ultra-clear, ADHD-friendly version** you can drop straight into your repo.

---

# 🧠 Terraform IAM JSON 

## 🔥 The Only Thing You Need to Remember

Terraform is **NOT JSON**.

If you are inside:

```hcl
jsonencode({ ... })
```

You use:

```
=
```

NOT

```
:
```

---

# ✅ Correct Example

```hcl
assume_role_policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Effect = "Allow"
      Action = "sts:AssumeRole"
    }
  ]
})
```

Notice:

```
Version = "2012-10-17"
```

NOT

```
Version: "2012-10-17"
```

---

# 🔄 What Terraform Does Behind The Scenes

You write:

```
Version = "2012-10-17"
```

Terraform converts it to:

```
"Version": "2012-10-17"
```

AWS only ever sees real JSON.

Terraform handles the conversion automatically.

---

# 🧠 Why Use `jsonencode()`?

Because it:

* Prevents broken JSON
* Lets you use variables
* Is cleaner than raw JSON blocks

---

# 🎯 Rule of Thumb

Inside Terraform → use `=`
Inside real JSON → use `:`

---

That’s it. Nothing more complicated than that.


