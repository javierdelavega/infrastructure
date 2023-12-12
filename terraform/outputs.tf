# Terraform outputs to be consumed by ansible

output "public_dns" {
  description = "The public DNS name assigned to the instance."
  value = aws_instance.proton.public_dns
}

output "public_ip" {
  description = "The public IP address assigned to the instance."
  value = aws_instance.proton.public_ip
}

output "private_key" {
  description = "Private ssh key"
  value = tls_private_key.proton_key.private_key_pem
  sensitive = true
}