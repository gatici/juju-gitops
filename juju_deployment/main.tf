module "cos" {
  source = "./cos"
  cloud_name = "eks_1"
}

module "sdcore" {
  source = "./sdcore"
  cloud_name = "eks_2"
  metrics_remote_write_offer_url = module.cos.metrics_remote_write_offer_url
  logging_offer_url = module.cos.logging_offer_url
}
