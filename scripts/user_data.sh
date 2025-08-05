#!/bin/bash
# user_data.sh - runs on EC2 instance at launch

# Update and install Docker
apt-get update -y
apt-get install -y docker.io

# Start Docker
systemctl start docker
systemctl enable docker

# Pull image from Docker Hub
docker pull dtbanda/slm-pi-app:arm64

# Run the container (port 8000 exposed)
docker run -dp 8000:8000 dtbanda/slm-pi-app:arm64
