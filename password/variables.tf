variable "username" {
  type        = string
  default     = "useradmin"
  description = "The username for which to create the password"
}


variable "path" {
  type        = string
  default     = "./keys"
  description = "The path in which to save the public and private keys"
}

variable "psw_lenght" {
  type       = number
  defautl    = 16
  descrition = "Length of the password"
}

variable "override_special" {
  type        = string
  default     = "!#%*()-_=+[]{}:?"
  description = "Specials characheter admitted for the password"
}