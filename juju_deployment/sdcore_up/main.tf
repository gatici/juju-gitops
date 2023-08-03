terraform {
  required_version = ">= 1.4"
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "0.8.0"
    }
  }
}

resource "juju_model" "sdcore_user_plane" {
  name = "sdcore-user-plane"
  cloud {
    name = var.cloud_name
  }
  credential = var.cloud_name
}

resource "juju_application" "upf" {
  name = "upf"
  model = juju_model.sdcore_user_plane.name
  trust = true

  charm {
    name = "sdcore-upf"
    channel  = "edge"
    series = "jammy"
  }

  units = 1
}

resource "juju_application" "grafana_agent" {
  name = "grafana-agent"
  model = juju_model.sdcore_user_plane.name

  charm {
    name = "grafana-agent-k8s"
    channel  = "latest/stable"
    series = "jammy"
  }

  units = 1
}

resource "juju_integration" "upf_metrics" {
  model = juju_model.sdcore_user_plane.name

  application {
    name     = juju_application.upf.name
    endpoint = "metrics-endpoint"
  }

  application {
    name     = juju_application.grafana_agent.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "metrics" {
  model = juju_model.sdcore_user_plane.name

  application {
    name     = juju_application.grafana_agent.name
    endpoint = "send-remote-write"
  }

  application {
    offer_url = var.metrics_remote_write_offer_url
  }
}
