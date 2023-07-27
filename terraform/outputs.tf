output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.EKS.cluster_endpoint
}
