output "instance_public_ip" {
  value = aws_instance.slm_instance.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/your-key.pem ubuntu@${aws_instance.slm_instance.public_ip}"
}
