resource "tls_private_key" "admin" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_password" "password" {
  length           = var.psw_lenght
  override_special = var.override_special
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
    command = var.os == "Linux" ? "puttygen ${var.path}/${var.username}.pem -o =${var.path}/${var.username}.ppk -P ${random_password.password.result}" : "winscp.com /keygen ${var.path}/${var.username}.pem /output=${var.path}/${var.username}.ppk /changepassphrase=${random_password.password.result}"
  }
  depends_on = [
    local_file.private_openssh_key_admin,
    random_password.password
  ]
}
