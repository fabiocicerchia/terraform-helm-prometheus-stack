# Prometheus Monitoring Module

Terraform module to deploy Prometheus monitoring stack on Kubernetes using Helm.

## Overview

Prometheus is the foundation of the monitoring stack, providing metrics collection, storage, and visualization. It includes Grafana and Alertmanager.

- **Kube Prometheus Stack**: Complete Prometheus, Grafana, and Alertmanager setup
- **Metrics Collection**: Automatic scraping of Kubernetes metrics
- **Grafana Dashboards**: Pre-configured dashboards for cluster monitoring
- **ServiceMonitor Integration**: Automatic service discovery for metrics scraping

## Quick Start

```hcl
module "prometheus" {
  source = "git::https://github.com/fabiocicerchia/tf-k8s-prometheus-stack-module.git?ref=main"

  kubeconfig_path = "~/.kube/config"
  release_name    = "prometheus-community"
  namespace       = "monitoring"
  values          = {}
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `kubeconfig_path` | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |
| `release_name` | Helm release name for Prometheus | `string` | `"prometheus-community"` | no |
| `namespace` | Kubernetes namespace for Prometheus | `string` | `"monitoring"` | no |
| `chart_version` | Helm chart version (empty string for latest) | `string` | `""` | no |
| `values` | Helm values for Prometheus deployment | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `namespace` | Kubernetes namespace where Prometheus is deployed |
| `release_name` | Helm release name of Prometheus |
| `chart_version` | Chart version of Prometheus deployment |

## Requirements

- Terraform >= 1.0
- Helm >= 2.0
- Kubernetes v1.24+
- kubectl configured to access your cluster

## Usage

### Basic Deployment

```hcl
module "prometheus" {
  source = "git::https://github.com/fabiocicerchia/tf-k8s-prometheus-stack-module.git?ref=main"

  kubeconfig_path = "~/.kube/config"
  namespace       = "monitoring"
}
```

### With Custom Values

```hcl
module "prometheus" {
  source = "git::https://github.com/fabiocicerchia/tf-k8s-prometheus-stack-module.git?ref=main"

  kubeconfig_path = "~/.kube/config"
  namespace       = "custom-monitoring"
  
  values = {
    prometheus = {
      prometheusSpec = {
        retention = "30d"
      }
    }
  }
}
```

### Pin Chart Version

```hcl
module "prometheus" {
  source = "git::https://github.com/fabiocicerchia/tf-k8s-prometheus-stack-module.git?ref=main"

  kubeconfig_path = "~/.kube/config"
  chart_version   = "51.0.0"
}
```

## Access Grafana

Port-forward to access Grafana:

```bash
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80
```

Visit `http://localhost:3000` (default credentials: admin/prom-operator)

## Resources

- [Prometheus Operator](https://prometheus-operator.dev/)
- [Kube Prometheus Stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)
- [Grafana](https://grafana.com/)
