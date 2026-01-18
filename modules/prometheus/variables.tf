variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "release_name" {
  description = "Helm release name for Prometheus"
  type        = string
  default     = "prometheus-community"
}

variable "namespace" {
  description = "Kubernetes namespace for Prometheus"
  type        = string
  default     = "monitoring"
}

variable "chart_version" {
  description = "Helm chart version (empty string for latest)"
  type        = string
  default     = ""
}

variable "values" {
  description = "Helm values for Prometheus deployment"
  type        = any
  default     = {}
}
