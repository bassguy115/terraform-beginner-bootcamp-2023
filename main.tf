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
  #cloud {
  #  organization = "Bassguy115"
#
  #  workspaces {
  #    name = "terra-house-1"
  #  }
 # }  
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  error_html_filepath = var.error_html_filepath
  index_html_filepath = var.index_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
} 

resource "terratowns_home" "home" {
  name = "Red and Black graphics and items are my favorite. How do you like the color combinations?"
  description = <<DESCRIPTION
The blend of red and black graphics are very attractive. Dont you think so? I have several of my computer peripherials in red and black.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "3fdq3gz.cloudfront.net"
  town = "missingo"
  content_version = 1
}
