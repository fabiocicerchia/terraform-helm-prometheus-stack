output "prometheus_namespace" {
  description = "The namespace where Prometheus is deployed"
  value       = module.prometheus.namespace
}

output "prometheus_release_name" {
  description = "The Helm release name of Prometheus"
  value       = module.prometheus.release_name
}

output "prometheus_chart_version" {
  description = "The chart version of the deployed Prometheus"
  value       = module.prometheus.chart_version
}
