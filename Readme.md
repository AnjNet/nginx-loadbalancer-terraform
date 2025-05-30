# Terraform AWS Nginx Load Balancer Infrastructure

## Overview

This Terraform project automates the deployment of a highly available web infrastructure on AWS. It provisions the following resources:

- A **VPC** with public subnets  
- **Security groups** to allow HTTP and SSH access  
- Two **EC2 instances** launched from a **custom AMI** running Nginx  
- An **Application Load Balancer (ALB)** distributing incoming traffic across the EC2 instances  
- The Nginx web servers display their respective **EC2 instance IDs** to verify load balancing  

---

## Architecture Diagram

[Internet] --> [ALB] --> [2x EC2 Instances in Public Subnets]

---

## Features

- Infrastructure-as-Code: Entire AWS setup described in Terraform scripts  
- Custom AMI used to pre-install Nginx and a simple webpage displaying instance metadata (instance ID)  
- Load Balancer automatically routes traffic and performs health checks  
- Secure access using a specified EC2 Key Pair for SSH  
- Clean modular structure with separate files for variables, outputs, and main configuration  

---

## Prerequisites

- AWS Account with permissions to create EC2, VPC, ALB, Security Groups, IAM resources  
- Terraform (v1.0 or later) installed locally: [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)  
- AWS CLI configured with your credentials: `aws configure`  
- Custom AMI ID available (created manually following the project steps)  
- SSH key pair already created in AWS and accessible locally (the private `.pem` file)  
- Internet connection to access AWS and Terraform Registry  

---

## Files Description

| Filename          | Purpose                                                      |
|-------------------|--------------------------------------------------------------|
| `main.tf`         | Core Terraform resources: VPC, Subnets, EC2, ALB, Security Groups |
| `variables.tf`    | Variable declarations for customizable values                |
| `outputs.tf`      | Output variables such as Load Balancer DNS name              |
| `terraform.tfvars`| User-specific variables like AMI ID, Key Pair name           |
| `userdata.sh`     | EC2 user data script to install nginx and customize the page |
| `.gitignore`      | Files to exclude from Git version control                     |
| `README.md`       | Project documentation                                         |

---

## Setup Instructions

### Step 1: Clone this Repository

```bash
git clone https://github.com/YOUR_USERNAME/nginx-loadbalancer-terraform.git
cd nginx-loadbalancer-terraform

```

### **Step 2: Edit terraform.tfvars**

Update with your specific values:
ami_id = "ami-xxxxxxxxxxxxxxxxx"    # Your custom AMI ID  
key_name = "YourKeyPairName"        # Your AWS EC2 Key Pair name (case sensitive)  
region = "us-east-1"                # AWS region  

### **Step 3: Initialize Terraform**
``` bash
terraform init

```
### **Step 4: Apply Terraform Configuration**
``` bash
terraform apply -var-file="terraform.tfvars"
```
Review the proposed plan.

Type yes to confirm.

### **Step 5: Access the Application**
Copy the Load Balancer DNS output from the Terraform apply.

Open it in a web browser: http://<load_balancer_dns>

You should see a simple page displaying the Instance ID of the Nginx server.

Refresh the page to see the Load Balancer switching between the two instances.

### **Clean Up Resources**
To avoid incurring charges, destroy the infrastructure when done:
terraform destroy -var-file="terraform.tfvars"

### **Troubleshooting**
InvalidKeyPair.NotFound — Ensure the key pair name in terraform.tfvars matches exactly the one in your AWS console.

Load Balancer creation delays — AWS may take a few minutes to provision the ALB and associated resources.

Instance Metadata issues — Check if IMDSv2 is enabled; if so, userdata may need updating to support token-based requests.

Permissions — Make sure your AWS credentials have necessary permissions for all resources used.

### **Further Improvements**
Add HTTPS support with ACM certificates and ALB listener rules

Use modules for reusability and better organization

Add CloudWatch monitoring and alarms

Implement autoscaling group instead of fixed 2 instances

Add detailed tagging and cost allocation tags

