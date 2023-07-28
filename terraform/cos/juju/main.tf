provider "juju" {}

resource "juju_model" "cos" {
  name = "cos"

  cloud {
    name   = "cos-eks"
    region = "es-east-2"
  }
}