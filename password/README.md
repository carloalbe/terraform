# CREATING A PUTTY PRIVATE KEY IN TERRAFORM 
The scope of this terraform module is the one of creating and saving passwords to authenticate in linux virtual machines. In particular it want to gives the possibility to create a **putty private key (ppk)**. In fact terraform existing provider [*"hashicorp/tls"*](https://registry.terraform.io/providers/hashicorp/tls/latest/docs) allows only creating a typical openssh key pem. In order to obtain a ppk this module uses the *local-exec* provisioner ([see here](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)) and associate by a command a random password to the private pem in order to generate a putty key that requires the password on authentification. 
Usually this is possible by using Putty CLI in linux ([Puttygen for Linux](https://www.puttygen.com/)). But since putty does not have CLI on Windows, this module is going to use [**WinSCP**](https://winscp.net/eng/index.php), a popular SFTP client and FTP client for Microsoft Windows! In order to use it, you need to install it and add the program to the environmental variable Path. To check if the tool has been correctly installed and added to the path, just run the command "winscp" from your prompt to see if ti is recognised.