terraform {
  required_version = ">= 0.12.26"
  required_providers {
    juju = {
      version = "~> 0.3.1"
      source  = "juju/juju"
    }
  }
}

provider "juju" {
  controller_addresses = "35.225.17.109:17070"

  username = "terraform"
  password = "password123"

  ca_certificate = <<EOT
-----BEGIN CERTIFICATE-----
MIIEEzCCAnugAwIBAgIVAPf93RlyLKjNnh8xqwdPY/V656+DMA0GCSqGSIb3DQEB
CwUAMCExDTALBgNVBAoTBEp1anUxEDAOBgNVBAMTB2p1anUtY2EwHhcNMjMwNzIx
MTczODE0WhcNMzMwNzIxMTc0MzE0WjAhMQ0wCwYDVQQKEwRKdWp1MRAwDgYDVQQD
EwdqdWp1LWNhMIIBojANBgkqhkiG9w0BAQEFAAOCAY8AMIIBigKCAYEA3fu7JgC/
XbQ9V8cqd6hY27VVAKYVSP5R17MmBBUgeS0UupPKUMxNhUKMHXa8iqQ64BoySa2W
DyQ+3mWKaXOUTbJewB/rkna6Gf0HL2pXy/1vptc9OdUs4Qi/2UNmAojSo107TSTA
DGoX6Tbnc+5WJ/KQjn0AWo1htDlvP3NnZagd1nc3km7lGeofLt02cqs/tf8E4vcP
9Xidng625eI+ElcfizQQzWTD3la4R5waZ9RdOiy0sZfMCzhmEgVMDW1KukaFQ24G
VnhdgICk1THiHJtiFBZYp5evSl1f6tKm/x6PnRhiqov5qq51ZecLyGIwjuRkuobx
8mKMgjO/YPeTJWE7SIWMBxALPupGFcoIeR4gtkZMMA9jMt7B1VRuQu8bF1fv3smu
FwM7MOrPWnrFyLvOPSPbag4y3wsCGeeeNZqZBZduIjyaNzXO6BMXBy84trAE1THA
lYk4BksnXl3b8AKt5Cfr/sb+XCTx5DmGr15QrpZ9wZc3R1t62ION4JL1AgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwICpDAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBTH
TIxD9R7VbAYkom4Mj8SwdeG83zANBgkqhkiG9w0BAQsFAAOCAYEATxhcRw7maQlg
ei2rRrbgeorbDJRnkTqLGrG7E6TD2yQQS1zyJSRxGPkrvM67rAVabIfYVtO1PFf7
1xg9Yoq3xqEUrEPvVX2HLCv8ZHwctpi9D0tSFNdJR2zkXMaTMkxcWgJnAJq5//+6
R96q7Uwv/2QShWhjmSk9qxhycOxZnTzHNnnBIT2DjyXl8lvMQezgn8sA/vXKdHEZ
tmq904TxK1AgLLCbvYZ/4SZHgHDkC/xLsEgC2K+iPIShvg9hCMtN76h/Adhjnw+G
2HIjx4VDzzenqn/nx81Fs3Gmpo9XNoCsEKFBXdoTKQ5otalMAqaNJ8U3jG1AbKDC
CAmje38QmDCqWTu+QpRnISDxjan+uSOvh+0u1lZ8VxjweH6vq/0QIq+ZtMTokj++
P8bn47mWGj0qRSvQEn0eEW/lNDkjUcSfs4EoylUPKMbUddBO4VWQYJxQ6tb3cGTI
Yx+aWfvi6YlEGSFZoDMDlCEa065fWviV7TCdFvqsuiGvwzblx/R5
-----END CERTIFICATE-----
EOT
}

resource "juju_model" "development" {
  name = "development"

  cloud {
    name   = "google"
    region = "us-central1-c"
  }
}

resource "juju_application" "wordpress" {
  name = "wordpress"

  model = juju_model.development.name

  charm {
    name = "wordpress"
  }

  units = 3
}

resource "juju_application" "percona-cluster" {
  name = "percona-cluster"

  model = juju_model.development.name

  charm {
    name = "percona-cluster"
  }

  units = 3
}

resource "juju_integration" "wp_to_percona" {
  model = juju_model.development.name

  application {
    name     = juju_application.wordpress.name
    endpoint = "db"
  }

  application {
    name     = juju_application.percona-cluster.name
    endpoint = "server"
  }
}