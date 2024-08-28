# Autoscaling App

## Overview

This project implements a high availability architecture on AWS using Terraform for resource provisioning. The architecture consists of EC2 instances in private subnets distributed across three Availability Zones, an Auto Scaling Group to manage these instances, a Load Balancer to distribute traffic, and an RDS database instance in a private subnet. An additional instance in a public subnet was created to simulate a Jenkins server.

## Architecture

![Project Architecture](./images/autoScalable.drawio.svg)

### Main Components

1. **VPC (Virtual Private Cloud):**  
   - A VPC that spans three Availability Zones.
   - Public and private subnets in all Availability Zones.

2. **EC2 Instances:**
   - EC2 instances provisioned in private subnets to ensure security.
   - The instances in private subnets are managed by an Auto Scaling Group to ensure high availability and resilience.
   - An EC2 instance in a public subnet was created to simulate a Jenkins server, allowing SSH and other necessary connections for administration.

3. **RDS (Relational Database Service):**
   - A MySQL database is provisioned in the private subnet, with enhanced security through specific security groups.
   - Subnet Group configured for the database with high availability across the three Availability Zones.

4. **Load Balancer:**
   - Incoming traffic is managed by a Load Balancer, which distributes requests among the EC2 instances in the private subnets.

5. **Security Groups:**
   - Security Groups configured to allow only the necessary traffic, such as SSH for Jenkins and MySQL for RDS.

## Prerequisites

- **Terraform**: Ensure that Terraform is installed on your development machine.
- **AWS CLI**: Configure your AWS credentials using the AWS CLI.
- **AWS Account**: An active AWS account for resource provisioning.
- **Remote tfstate**: This project uses a remote backend to store the Terraform state (`tfstate`), ensuring that the state is maintained consistently and securely.

## How to Use

### 1. Clone the repository to your local machine:

```git clone https://github.com/Alves0611/autoscaling-app```


**Terraform Initialization**: In the project's `terraform` directory, run the following command to initialize Terraform:

```bash
cd <directory-name>

terraform init
```

- To use the remote backend, run:

```bash
terraform init -backend=true -backend-config="config/dev/backend.hcl"
```

**Apply the configurations:** To provision the infrastructure, run:

```bash
terraform apply
```

**Destroy the infrastructure:** If you need to remove the provisioned infrastructure, use:

```bash
terraform destroy
```
