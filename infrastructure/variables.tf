variable "aws_region" {
  default = "eu-north-1"
}

variable "public_key_path" {
  description = "Path to your local public SSH key"
  default     = "~/.ssh/id_rsa.pub"
}

variable "ami_id" {
  description = "Ubuntu arm64 machine"
  default     = "ami-008e58f8f6505bf76" 
}

variable "instance_type" {
  default = "t4g.small" #Graviton arm architecture
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "liquid_ai_lab"
}
