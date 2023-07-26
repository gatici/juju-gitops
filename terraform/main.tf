
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }

  backend "s3" {
   bucket = "tfstate-gruyaume"
   region = "us-east-2"
   key    = "terraform.tfstate"
 }
}


provider "aws" {
  region = "us-east-2"
}
