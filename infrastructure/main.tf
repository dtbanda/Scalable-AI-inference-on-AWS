terraform {
  cloud {
    organization = "dtbinsights"
    workspaces {
      name = "devops-labs_terraform"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "var.aws_region"
}

resource "aws_key_pair" "slm_key" {
  key_name   = "slm-key"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "slm_sg" {
  name        = "slm-api-sg"
  description = "Allow SSH and API access"

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami                         = "var.ami_id"
  instance_type               = "var.instance_type"
  key_name                    = "devops-labs"
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.slm_sg.id]
  
  tags = {
    Name = "var.instance_name"
  }

  user_data = file("user_data.sh") # install Docker & run container

}
