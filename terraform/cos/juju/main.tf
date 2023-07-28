
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
    name = "cos-eks"
  }
  credential = "cos-eks"
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

resource "juju_integration" "metrics" {
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

#- [grafana:grafana-source, prometheus:grafana-source]
#- [prometheus:metrics-endpoint, traefik:metrics-endpoint]
#- [prometheus:metrics-endpoint, grafana:metrics-endpoint]
#- [grafana:grafana-dashboard, prometheus:grafana-dashboard]