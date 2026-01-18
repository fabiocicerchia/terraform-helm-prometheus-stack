kubeconfig_path = "~/.kube/config"
release_name    = "prometheus-community"
namespace       = "monitoring"
chart_version   = ""
# https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/values.yaml
values = {
  prometheus = {
    prometheusSpec = {
      serviceMonitorSelectorNilUsesHelmValues = false
    }
  }
}
