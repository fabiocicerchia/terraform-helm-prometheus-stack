output "namespace" {
  description = "The namespace where Prometheus is deployed"
  value       = module.prometheus.namespace
}

output "release_name" {
  description = "The Helm release name of Prometheus"
  value       = module.prometheus.release_name
}

output "version" {
  description = "The version of Prometheus deployed"
  value       = module.prometheus.version
}
