variable "argocd_chart_version" {
  default = "5.52.2"
}

variable "argocd_admin_password" {

}

variable "argocd_insecure" {

}

variable "argocd_values_file" {
  default = "argocd/values.yaml"
}



variable "traefik_values_file" {
  default = "traefik/values.yaml"
}
