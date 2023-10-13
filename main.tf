terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
#backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "Bassguy115"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
    organization = "Bassguy115"
    workspaces {
      name = "terra-house-1"
    }
 }  
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_redandblack_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.redandblack.public_path
  content_version = var.redandblack.content_version  
} 

resource "terratowns_home" "home_redandblack" {
  name = "Red and Black graphics and items are my favorite. How do you like the color combinations?"
  description = <<DESCRIPTION
The blend of red and black graphics are very attractive. Dont you think so? I have several of my computer peripherials in red and black.
DESCRIPTION
  domain_name = module.home_redandblack_hosting.domain_name
  #domain_name = "3fdq3gz.cloudfront.net"
  town = "missingo"
  content_version = var.redandblack.content_version
}

module "home_bassandfishing_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.bassandfishing.public_path
  content_version = var.bassandfishing.content_version
  
} 

resource "terratowns_home" "home_bassandfishing" {
  name = "bassandfishing"
  description = <<DESCRIPTION
Do you like fishing or playing Bass? Well dont be confused becase bassguy can be used either way. We can learn about fishing here.
DESCRIPTION
  domain_name = module.home_bassandfishing_hosting.domain_name
  town = "nomad"
  content_version = var.bassandfishing.content_version
}
