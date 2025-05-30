# Nginx Load Balancer on AWS with Terraform

This project uses Terraform to provision:

- A VPC, subnets, and security groups
- Two EC2 instances based on a custom AMI with Nginx installed
- An Application Load Balancer in front of both instances

## Features

- Each Nginx server displays its EC2 instance ID
- Load Balancer rotates traffic between servers
- Infrastructure is defined entirely in code

## Usage

1. Clone the repo
2. Update `terraform.tfvars` with your AMI ID and Key Pair
3. Run:
terraform init
terraform apply -var-file="terraform.tfvars"