
module "kubernetes" {
  source = "./kubernetes"
}

provider "aws" {
  region = "us-east-2"
}
