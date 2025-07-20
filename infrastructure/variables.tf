variable "aws_region" {
  default = "eu-north-1"
}

variable "public_key_path" {
  description = "Path to your local public SSH key"
  default     = "~/.ssh/id_rsa.pub"
}

variable "ami_id" {
  description = "Ubuntu AMI ID"
  default     = "ami-005618638b1adde72" 
}

variable "instance_type" {
  default = "t3.micro" # Use g4dn.xlarge if you want a GPU
}
