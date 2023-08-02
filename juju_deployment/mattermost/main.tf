
terraform {
  required_version = ">= 1.4"
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "0.8.0"
    }
  }
}


resource "juju_model" "mattermost" {
  name = "mattermost"
  cloud {
    name = var.cloud_name
  }
  credential = var.cloud_name
}

resource "juju_application" "mattermost" {
  name = "mattermost-k8s"
  model = juju_model.mattermost.name

  charm {
    name = "mattermost-k8s"
    channel  = "latest/stable"
  }

  units = 1
}
