terraform {
  required_version = ">= 1.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

module "prometheus" {
  source = "../"

  release_name  = "prometheus"
  namespace     = "prometheus-system"
  chart_version = ""

  values = yamlencode({})
}
