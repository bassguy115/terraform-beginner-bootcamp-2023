terraform {
#backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "Bassguy115"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "Bassguy115"
#
  #  workspaces {
  #    name = "terra-house-1"
  #  }
 # }  
  required_providers {
     aws = {
      source = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

provider "aws" {
}
provider "random" {
  # Configuration options
}