resource "helm_release" "prometheus_community" {
  name       = var.release_name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.chart_version != "" ? var.chart_version : null

  dependency_update = true
  create_namespace  = true
  namespace         = var.namespace
  replace           = true

  values = [yamlencode(var.values)]
}
