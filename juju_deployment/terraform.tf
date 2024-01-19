
terraform {

  backend "s3" {
    bucket = "jujuterraform"
    region = "us-east-1"
    key    = "aws/s3"
  }

  required_version = "~> 1.3"
}
