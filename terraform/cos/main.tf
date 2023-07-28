
module "EKS" {
  source = "./eks"
  region = var.region
}

module "juju_cos" {
  source = "./juju"
}
