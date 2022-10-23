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
