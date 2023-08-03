module "cos" {
  source = "./cos"
  cloud_name = "eks_1"
}

module "sdcore_cp" {
  source = "./sdcore_cp"
  cloud_name = "eks_2"
  metrics_remote_write_offer_url = module.cos.metrics_remote_write_offer_url
  logging_offer_url = module.cos.logging_offer_url
}

# module "sdcore_up" {
#   source = "./sdcore_up"
#   cloud_name = "eks_multus_1"
#   metrics_remote_write_offer_url = module.cos.metrics_remote_write_offer_url
#   logging_offer_url = module.cos.logging_offer_url
# }
