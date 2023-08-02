
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

resource "juju_application" "postgresql" {
  name = "postgresql-k8s"
  model = juju_model.mattermost.name
  trust = true

  charm {
    name = "postgresql-k8s"
    channel  = "latest/stable"
  }

  units = 1
}

resource "juju_integration" "db" {
  model = juju_model.mattermost.name

  application {
    name     = juju_application.mattermost.name
    endpoint = "db"
  }

  application {
    name     = juju_application.postgresql.name
    endpoint = "db"
  }
}
