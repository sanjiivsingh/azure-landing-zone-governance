# Deployment Guide: Governance Landing Zone

## Prerequisites
- Terraform >= 1.9.0
- Azure CLI authenticated with `Owner` or `Resource Policy Contributor` role on the target subscription.

## Step-by-Step CLI Rollout
```bash
cd environments/dev
terraform init
terraform plan -var-file="terraform.tfvars.example"
terraform apply -var-file="terraform.tfvars.example"
```
