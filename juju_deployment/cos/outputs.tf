
output "metrics_remote_write_offer_url" {
  description = "Prometheus Metrics Offer URL"
  value       = juju_offer.metrics.url
}
