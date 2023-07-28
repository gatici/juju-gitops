#
#terraform {
#  required_version = ">= 1.4"
#  required_providers {
#    juju = {
#      source  = "juju/juju"
#      version = "0.8.0"
#    }
#  }
#}

module "EKS" {
  source = "./eks"
  region = var.region
}

module "juju_cos" {
  source = "./juju"
}
