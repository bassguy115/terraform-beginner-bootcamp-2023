terraform {
  required_providers {
     aws = {
      source = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}


# https://developer.hashicorp.com/terraform/language/data-sources
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "current" {}