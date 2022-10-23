output "password" {
  sensitive   = true
  value       = random_password.password.result
  description = "The created password"
}

output "publickey" {
  sensitive   = true
  value       = tls_private_key.admin.public_key_openssh
  description = "The puclic open SSH key"
}