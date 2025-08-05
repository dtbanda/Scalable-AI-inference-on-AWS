#!/bin/bash
# deploy_model.sh - builds, pushes and deploys the model

set -e

echo "Pushing Docker image to ECR..."
./scripts/push_to_ecr.sh

echo "Deploying infrastructure via Terraform..."
cd infrastructure
terraform init
terraform apply -auto-approve

echo "Deployment complete!"
echo "Instance IP:"
terraform output instance_public_ip
echo "SSH command:"
terraform output ssh_command 
