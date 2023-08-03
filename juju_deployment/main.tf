module "cos" {
  source = "./cos"
  cloud_name = "eks_1"
}

module "mattermost" {
  source = "./mattermost"
  cloud_name = "eks_2"
  metrics_offer_url = module.cos.metrics_offer_url
}

module "sdcore" {
  source = "./sdcore"
  cloud_name = "eks_2"
  metrics_offer_url = module.cos.metrics_offer_url
}