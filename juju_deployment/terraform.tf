
terraform {

  backend "s3" {
    bucket = "tfdemo-juju"
    region = "us-east-2"
    key    = "terraform.tfstate"
  }

  required_version = "~> 1.3"
}
