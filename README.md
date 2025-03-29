# terraform-aws

# Terraform AWS Infrastructure Setup

This repository contains Terraform configuration files to set up infrastructure on Amazon Web Services (AWS). The resources are created using the **AWS Provider** for Terraform and include components like VPC, Subnets, Internet Gateway, Route Tables, Security Groups, and EC2 instances.

## Resources Managed by Terraform

- **VPC**: Virtual Private Cloud (VPC) with CIDR block `10.0.0.0/16`
- **Subnet**: Public Subnet in Availability Zone `us-east-1a` with CIDR block `10.0.1.0/24`
- **Internet Gateway**: Provides Internet access to the VPC
- **Route Table**: Configured with a default route to the Internet Gateway
- **Security Group**: A security group allowing inbound SSH (port 22) and all traffic (all ports, both inbound and outbound)
- **EC2 Instance**: A basic EC2 instance in the public subnet with the `t2.micro` instance type

## Prerequisites

Before applying this configuration, ensure you have the following:

- **Terraform** installed on your local machine.
- **AWS CLI** configured with appropriate credentials and permissions to create resources in your AWS account.

## Setup Instructions

### 1. Clone the Repository

Clone this repository to your local machine:

## 2. Set Variables
## Edit the terraform.tfvars file to set the necessary variables:

## 3. Initialize Terraform
Run the following command to initialize the Terraform configuration and download the required provider plugins:

terraform init

## 4. Plan the Infrastructure
After initialization, you can run the following command to check the execution plan:

terraform plan

This will show you what resources will be created, modified, or destroyed.

## 5. Apply the Configuration
To create the infrastructure on AWS, run the following command:

terraform apply
Just so you know, you will be prompted to confirm the plan by typing yes.

## 6. Destroy the Infrastructure
To clean up and destroy the created resources, run:

terraform destroy
Again, you'll be prompted to confirm by typing yes.
