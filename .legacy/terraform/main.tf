terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.0.2"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "../kubeconfig"
  }
}

module "argocd" {
  source = "aigisuk/argocd/kubernetes"

  argocd_chart_version = var.argocd_chart_version
  insecure             = var.argocd_insecure
  admin_password       = var.argocd_admin_password
  values_file          = var.argocd_values_file
}


module "traefik" {
  source  = "aigisuk/traefik/kubernetes"
  version = "0.2.1"

  traefik_chart_version = var.traefik_chart_version
  values_file           = var.traefik_values_file
}
