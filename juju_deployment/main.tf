module "cos" {
  source = "./cos"
  cloud_name = "eks_1"
}

module "mattermost" {
  source = "./mattermost"
  cloud_name = "eks_2"
}
