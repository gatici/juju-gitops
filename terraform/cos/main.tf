
module "EKS" {
  source = "./eks"
  region = var.region
}

#module "juju_cos" {
#  source = "./juju"
#}

provider "juju" {}

resource "juju_model" "cos" {
  name = "cos"

  cloud {
    name   = "cos-eks"
    region = "es-east-2"
  }
}
