terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "app_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "devops-labs"
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.allow_ssh_docker_app.id]

  user_data = file("${path.module}/../scripts/user_data.sh")
  
  tags = {
    Name = var.instance_name
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "allow_ssh_docker_app" {
  name ="allow_ssh_&_docker_app"
  description = "allow ssh and docker app port 8000"
  vpc_id = data.aws_vpc.default.id

  ingress {
    description = "SSH access"
    from_port = 22
    to_port =22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Docker app - port 8000"
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    name = "allow_ssh_&_docker_app"
  }
}