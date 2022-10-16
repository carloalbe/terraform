terraform {

  required_version = ">= 1.0.0"

  required_providers {


    tls = {
      source  = "hashicorp/tls"
      version = "4.0.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }

  }
}



variable "username" {
  type = string
}


variable "path" {
  type    = string
  default = "./keys"
}

resource "tls_private_key" "admin" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_password" "password" {
  length = 16
  override_special = "!#%*()-_=+[]{}:?"
}


resource "local_file" "password" {
  content  = random_password.password.result
  filename = "${var.path}/${var.username}.txt"
}
resource "local_file" "private_openssh_key_admin" {
  content  = tls_private_key.admin.private_key_openssh
  filename = "${var.path}/${var.username}.pem"
}

resource "local_file" "public_openssh_key_admin" {
  content  = tls_private_key.admin.public_key_openssh
  filename = "${var.path}/${var.username}.pub"
}

resource "null_resource" "pem2ppk" {
  provisioner "local-exec" {
    command = "winscp.com /keygen ${var.path}/${var.username}.pem /output=${var.path}/${var.username}.ppk /changepassphrase=${random_password.password.result}"
  }
  depends_on = [
    local_file.private_openssh_key_admin,
    random_password.password
  ]
}



output "password" {
  sensitive = true
  value = random_password.password.result
}

output "publickey" {
  sensitive = true
  value = tls_private_key.admin.public_key_openssh
}