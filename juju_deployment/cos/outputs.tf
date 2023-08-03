
output "metrics_remote_write_offer_url" {
  description = "Prometheus Remote Write Metrics Offer URL"
  value       = juju_offer.metrics_remote_write.url
}

output "logging_offer_url" {
  description = "Loki Logging Offer URL"
  value       = juju_offer.logging.url
}
