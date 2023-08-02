
module "eks_1" {
  source = "./kubernetes"
  region = "us-east-2"
  cluster_name = "demo_eks_1"
  vpc_name = "demo_1"
}

module "eks_2" {
  source = "./kubernetes"
  region = "us-east-2"
  cluster_name = "demo_eks_2"
  vpc_name = "demo_2"
}
