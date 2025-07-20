#!/bin/bash
# push_to_ecr.sh - builds and pushes image to AWS ECR

set -e

REGION="us-east-1"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REPO_NAME="slm-api"
IMAGE_TAG="latest"

# Build Docker image
docker build -t ${REPO_NAME}:${IMAGE_TAG} .

# Tag image for ECR
docker tag ${REPO_NAME}:${IMAGE_TAG} ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}

# Login to ECR
aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com

# Create repo if it doesn’t exist
aws ecr describe-repositories --repository-names "${REPO_NAME}" --region ${REGION} > /dev/null 2>&1 || \
aws ecr create-repository --repository-name "${REPO_NAME}" --region ${REGION}

# Push image
docker push ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}
