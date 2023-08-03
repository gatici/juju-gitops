
terraform {
  required_version = ">= 1.4"
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "0.8.0"
    }
  }
}


resource "juju_model" "cos" {
  name = "cos"
  cloud {
    name = var.cloud_name
  }
  credential = var.cloud_name
}

resource "juju_application" "grafana" {
  name = "grafana"
  model = juju_model.cos.name
  trust = true

  charm {
    name = "grafana-k8s"
    channel  = "latest/stable"
  }

  units = 1
}

resource "juju_application" "prometheus" {
  name = "prometheus"
  model = juju_model.cos.name
  trust = true

  charm {
    name = "prometheus-k8s"
    channel  = "latest/stable"
  }

  units = 1
}

resource "juju_application" "loki" {
  name = "loki"
  model = juju_model.cos.name
  trust = true

  charm {
    name = "loki-k8s"
    channel  = "latest/stable"
  }

  units = 1
}

resource "juju_application" "traefik" {
  name = "traefik"
  model = juju_model.cos.name
  trust = true

  charm {
    name = "traefik-k8s"
    channel  = "latest/stable"
  }

  units = 1
}

resource "juju_integration" "grafana_source" {
  model = juju_model.cos.name

  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-source"
  }

  application {
    name     = juju_application.prometheus.name
    endpoint = "grafana-source"
  }
}

resource "juju_integration" "grafana_metrics" {
  model = juju_model.cos.name

  application {
    name     = juju_application.grafana.name
    endpoint = "metrics-endpoint"
  }

  application {
    name     = juju_application.prometheus.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "dashboard" {
  model = juju_model.cos.name

  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-dashboard"
  }

  application {
    name     = juju_application.prometheus.name
    endpoint = "grafana-dashboard"
  }
}

resource "juju_integration" "prometheus_ingress" {
  model = juju_model.cos.name

  application {
    name     = juju_application.traefik.name
    endpoint = "ingress-per-unit"
  }

  application {
    name     = juju_application.prometheus.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "loki_ingress" {
  model = juju_model.cos.name

  application {
    name     = juju_application.traefik.name
    endpoint = "ingress-per-unit"
  }

  application {
    name     = juju_application.loki.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "grafana_ingress" {
  model = juju_model.cos.name

  application {
    name     = juju_application.traefik.name
    endpoint = "traefik-route"
  }

  application {
    name     = juju_application.grafana.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "traefik_metrics" {
  model = juju_model.cos.name

  application {
    name     = juju_application.prometheus.name
    endpoint = "metrics-endpoint"
  }

  application {
    name     = juju_application.traefik.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "loki_metrics" {
  model = juju_model.cos.name

  application {
    name     = juju_application.loki.name
    endpoint = "metrics-endpoint"
  }

  application {
    name     = juju_application.prometheus.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "loki_dashboard" {
  model = juju_model.cos.name

  application {
    name     = juju_application.loki.name
    endpoint = "grafana-dashboard"
  }

  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-dashboard"
  }
}

resource "juju_offer" "metrics_remote_write" {
  model            = juju_model.cos.name
  application_name = juju_application.prometheus.name
  endpoint         = "receive-remote-write"
}

resource "juju_offer" "logging" {
  model            = juju_model.cos.name
  application_name = juju_application.loki.name
  endpoint         = "logging"
}
