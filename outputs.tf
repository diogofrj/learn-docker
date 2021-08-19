
output "ec2instance" {
  value = "ssh -o StrictHostKeyChecking=no -i iackey.pem ubuntu@${aws_instance.project-iac.public_ip}"
}