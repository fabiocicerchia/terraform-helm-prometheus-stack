# Terraform Module for Prometheus

Terraform module to deploy Prometheus monitoring stack on Kubernetes using Helm.

## Overview

Prometheus is the foundation of the monitoring stack, providing metrics collection, storage, and visualisation. It includes Grafana and Alertmanager.

- **Kube Prometheus Stack**: Complete Prometheus, Grafana, and Alertmanager setup
- **Metrics Collection**: Automatic scraping of Kubernetes metrics
- **Grafana Dashboards**: Pre-configured dashboards for cluster monitoring
- **ServiceMonitor Integration**: Automatic service discovery for metrics scraping

## Quick Start

```hcl
module "prometheus" {
  source = "fabiocicerchia/prometheus-stack/helm"

  release_name    = "prometheus-community"
  namespace       = "monitoring"
  values          = {}
}
```

## Inputs

| Name            | Description                                  | Type     | Default                  | Required |
| --------------- | -------------------------------------------- | -------- | ------------------------ | -------- |
| `release_name`  | Helm release name for Prometheus             | `string` | `"prometheus-community"` | no       |
| `namespace`     | Kubernetes namespace for Prometheus          | `string` | `"monitoring"`           | no       |
| `chart_version` | Helm chart version (empty string for latest) | `string` | `""`                     | no       |
| `values`        | Helm values for Prometheus deployment        | `any`    | `{}`                     | no       |

## Outputs

| Name            | Description                                       |
| --------------- | ------------------------------------------------- |
| `namespace`     | Kubernetes namespace where Prometheus is deployed |
| `release_name`  | Helm release name of Prometheus                   |
| `chart_version` | Chart version of Prometheus deployment            |

## Requirements

- Terraform >= 1.0 or OpenTofu >= 1.6
- Helm >= 2.0
- Kubernetes v1.24+
- kubectl configured to access your cluster

## Usage

### Basic Deployment

```hcl
module "prometheus" {
  source = "fabiocicerchia/prometheus-stack/helm"

  namespace       = "monitoring"
}
```

### With Custom Values

```hcl
module "prometheus" {
  source = "fabiocicerchia/prometheus-stack/helm"

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
  source = "fabiocicerchia/prometheus-stack/helm"

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

## Make targets

`make help` lists them. Every repository in this estate exposes the same eight
verbs, so you do not have to read a Makefile to find out how to build or test it
(FC-GEN-057).

| Verb      | What it does here                                    |
| --------- | ---------------------------------------------------- |
| `setup`   | Install the pre-commit hook                          |
| `install` | Download the providers this module pins              |
| `lint`    | `pre-commit run --all-files` — the whole gate        |
| `format`  | `terraform fmt -recursive`                           |
| `test`    | `terraform validate` on the module and every example |
| `analyze` | `tflint --recursive`                                 |

### Not applicable

Two verbs have no meaning for a Terraform module. They exit 0 and say so rather
than pretending to work (FC-GEN-058):

- `build` — nothing is compiled; the module is consumed from source.
- `run` — a module is instantiated by a root module, never executed directly.

## License

MIT
