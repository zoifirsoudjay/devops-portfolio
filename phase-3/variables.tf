variable "argocd_namespace" {
  description = "Namespace où ArgoCD sera installé"
  type        = string
  default     = "argocd"
}

variable "app_namespace" {
  description = "Namespace de l'application Flask"
  type        = string
  default     = "flask-app"
}

variable "github_repo" {
  description = "URL du repo GitHub"
  type        = string
  # à renseigner dans terraform.tfvars
}

variable "argocd_version" {
  description = "Version du chart Helm ArgoCD"
  type        = string
  default     = "6.7.3"
}