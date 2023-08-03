
terraform {
  required_version = ">= 1.4"
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "0.8.0"
    }
  }
}

resource "juju_model" "sdcore" {
  name = "sdcore"
  cloud {
    name = var.cloud_name
  }
  credential = var.cloud_name
}

resource "juju_application" "amf" {
  name = "amf"
  model = juju_model.sdcore.name
  trust = true

  charm {
    name = "sdcore-amf"
    channel  = "edge"
    series = "jammy"
  }

  units = 1
}

resource "juju_application" "ausf" {
  name = "ausf"
  model = juju_model.sdcore.name
  trust = true

  charm {
    name = "sdcore-ausf"
    channel  = "edge"
    series = "jammy"
  }

  units = 1
}

resource "juju_application" "nssf" {
  name = "nssf"
  model = juju_model.sdcore.name
  trust = true

  charm {
    name = "sdcore-nssf"
    channel  = "edge"
    series = "jammy"
  }

  units = 1
}


resource "juju_application" "nrf" {
  name = "nrf"
  model = juju_model.sdcore.name
  trust = true

  charm {
    name = "sdcore-nrf"
    channel  = "edge"
    series = "jammy"
  }

  units = 1
}

resource "juju_application" "pcf" {
  name = "pcf"
  model = juju_model.sdcore.name
  trust = true

  charm {
    name = "sdcore-pcf"
    channel  = "edge"
    series = "jammy"
  }

  units = 1
}

resource "juju_application" "smf" {
  name = "smf"
  model = juju_model.sdcore.name
  trust = true

  charm {
    name = "sdcore-smf"
    channel  = "edge"
    series = "jammy"
  }

  units = 1
}

resource "juju_application" "udm" {
  name = "udm"
  model = juju_model.sdcore.name
  trust = true

  charm {
    name = "sdcore-udm"
    channel  = "edge"
    series = "jammy"
  }

  units = 1
}

resource "juju_application" "udr" {
  name = "udr"
  model = juju_model.sdcore.name
  trust = true

  charm {
    name = "sdcore-udr"
    channel  = "edge"
    series = "jammy"
  }

  units = 1
}

resource "juju_application" "mongodb" {
  name = "mongodb"
  model = juju_model.sdcore.name
  trust = true

  charm {
    name = "mongodb-k8s"
    channel  = "5/edge"
    series = "jammy"
  }

  units = 1
}

resource "juju_application" "grafana_agent" {
  name = "grafana-agent"
  model = juju_model.sdcore.name

  charm {
    name = "grafana-agent-k8s"
    channel  = "latest/stable"
    series = "jammy"
  }

  units = 1
}

resource "juju_application" "webui" {
  name = "webui"
  model = juju_model.sdcore.name
  trust = true

  charm {
    name = "sdcore-webui"
    channel  = "edge"
    series = "jammy"
  }

  units = 1
}

resource "juju_integration" "amf_nrf" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.amf.name
    endpoint = "fiveg_nrf"
  }

  application {
    name     = juju_application.nrf.name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "ausf_nrf" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.ausf.name
    endpoint = "fiveg_nrf"
  }

  application {
    name     = juju_application.nrf.name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "nssf_nrf" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.nssf.name
    endpoint = "fiveg_nrf"
  }

  application {
    name     = juju_application.nrf.name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "pcf_nrf" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.pcf.name
    endpoint = "fiveg_nrf"
  }

  application {
    name     = juju_application.nrf.name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "smf_nrf" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.smf.name
    endpoint = "fiveg_nrf"
  }

  application {
    name     = juju_application.nrf.name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "udm_nrf" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.udm.name
    endpoint = "fiveg_nrf"
  }

  application {
    name     = juju_application.nrf.name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "udr_nrf" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.udr.name
    endpoint = "fiveg_nrf"
  }

  application {
    name     = juju_application.nrf.name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "amf_database" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.amf.name
    endpoint = "database"
  }

  application {
    name     = juju_application.mongodb.name
    endpoint = "database"
  }
}

resource "juju_integration" "nrf_database" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.nrf.name
    endpoint = "database"
  }

  application {
    name     = juju_application.mongodb.name
    endpoint = "database"
  }
}

resource "juju_integration" "pcf_database" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.pcf.name
    endpoint = "database"
  }

  application {
    name     = juju_application.mongodb.name
    endpoint = "database"
  }
}

resource "juju_integration" "smf_database" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.smf.name
    endpoint = "database"
  }

  application {
    name     = juju_application.mongodb.name
    endpoint = "database"
  }
}

resource "juju_integration" "udr_database" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.udr.name
    endpoint = "database"
  }

  application {
    name     = juju_application.mongodb.name
    endpoint = "database"
  }
}

resource "juju_integration" "webui_database" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.webui.name
    endpoint = "database"
  }

  application {
    name     = juju_application.mongodb.name
    endpoint = "database"
  }
}

resource "juju_integration" "amf_metrics" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.amf.name
    endpoint = "metrics-endpoint"
  }

  application {
    name     = juju_application.grafana_agent.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "smf_metrics" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.smf.name
    endpoint = "metrics-endpoint"
  }

  application {
    name     = juju_application.grafana_agent.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "mongodb_metrics" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.mongodb.name
    endpoint = "metrics-endpoint"
  }

  application {
    name     = juju_application.grafana_agent.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "mongodb_logging" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.mongodb.name
    endpoint = "logging"
  }

  application {
    name     = juju_application.grafana_agent.name
    endpoint = "logging-provider"
  }
}

resource "juju_integration" "metrics" {
  model = juju_model.sdcore.name

  application {
    name     = juju_application.grafana_agent.name
    endpoint = "send-remote-write"
  }

  application {
    offer_url = var.metrics_remote_write_offer_url
  }
}
