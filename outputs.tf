output "namespace" {
  description = "Kubernetes namespace where Prometheus is deployed"
  value       = helm_release.prometheus_community.namespace
}

output "release_name" {
  description = "Helm release name of Prometheus"
  value       = helm_release.prometheus_community.name
}

output "chart_version" {
  description = "Chart version of Prometheus deployment"
  value       = helm_release.prometheus_community.version
}
