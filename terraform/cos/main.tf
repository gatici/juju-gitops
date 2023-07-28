
module "EKS" {
  source = "./eks"
  region = var.region
}

module "juju" {
  source = "./juju"
}
