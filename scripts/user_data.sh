#!/bin/bash
# user_data.sh - runs on EC2 instance at launch

# Update and install Docker
apt-get update -y
apt-get install -y docker.io

# Start Docker
systemctl start docker
systemctl enable docker

# Login to ECR (assumes IAM role or keys are attached)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <your_account_id>.dkr.ecr.us-east-1.amazonaws.com

# Pull image from ECR
docker pull <your_account_id>.dkr.ecr.us-east-1.amazonaws.com/slm-api:latest

# Run the container (port 8000 exposed)
docker run -d -p 8000:8000 --name slm-api <your_account_id>.dkr.ecr.us-east-1.amazonaws.com/slm-api:latest
