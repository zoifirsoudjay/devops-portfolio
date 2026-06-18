# DevOps Portfolio

Portfolio infrastructure progressif couvrant la virtualisation locale,
le CI/CD, et le déploiement cloud sur AWS.

## Stack
KVM · Docker · Jenkins · Nexus · Terraform · Kubernetes · ArgoCD · ELK · GitHub

## Structure

| Dossier    | Contenu                                          |
|------------|--------------------------------------------------|
| phase-1/   | Environnement local — Docker, Jenkins, Nexus     |
| phase-2/   | Pipeline CI/CD — Jenkins, Webhook, build Docker  |
| phase-3/   | Cloud & GitOps — AWS EKS, Terraform, ArgoCD, ELK |
| app/       | Application de démonstration                     |
| docs/      | Schémas d'architecture                           |

## Prérequis
- Windows 10/11 Pro avec Hyper-V activé
- Ubuntu Server 24.04 en VM
- Docker installé dans la VM
