# Récupérer le contexte minikube automatiquement
data "external" "minikube_ip" {
  program = ["bash", "-c", "echo '{\"ip\": \"'$(minikube ip)'\"}'"]
}

# Provider Kubernetes — pointe sur minikube
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

# Provider Helm — même contexte
provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "minikube"
  }
}

# Namespace ArgoCD
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
  }
}

# Namespace Flask app
resource "kubernetes_namespace" "flask_app" {
  metadata {
    name = var.app_namespace
  }
}

# Installation ArgoCD via Helm
resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_version

  # Désactiver TLS pour simplifier l'accès local
  set {
    name  = "configs.params.server\\.insecure"
    value = "true"
  }

  # Activer le metrics server
  set {
    name  = "controller.metrics.enabled"
    value = "true"
  }

  timeout = 300 # 5 min max pour le pull des images
}

# Application ArgoCD — pointe sur phase-3/k8s/ du repo
resource "kubernetes_manifest" "argocd_app" {
  depends_on = [helm_release.argocd]

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "flask-app"
      namespace = var.argocd_namespace
    }
    spec = {
      project = "default"
      source = {
        repoURL        = var.github_repo
        targetRevision = "main"
        path           = "phase-3/k8s"
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = var.app_namespace
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = ["CreateNamespace=true"]
      }
    }
  }
}