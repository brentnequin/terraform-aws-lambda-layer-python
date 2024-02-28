terraform {
  required_providers {
    temporary = {
      source = "kota65535/temporary"
      version = "0.1.0"
    }
  }
}

provider "temporary" {
  base = "${path.root}/.terraform"
}