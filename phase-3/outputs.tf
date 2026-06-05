output "argocd_url" {
  description = "URL d'accès à ArgoCD (après port-forward)"
  value       = "http://localhost:8083"
}

output "argocd_get_password_cmd" {
  description = "Commande pour récupérer le mot de passe admin"
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}

output "minikube_ip" {
  description = "IP de minikube (pour le registre Nexus)"
  value       = data.external.minikube_ip.result.ip
}