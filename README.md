# ⚡ TaskFlow — Three-Tier EKS Project

A production-grade **Task Manager** application demonstrating a complete DevOps pipeline on AWS EKS.

## 🏗️ Architecture

```
Internet
    │
    ▼
AWS ALB (Ingress)
    ├──► /api/*  ──► Node.js Backend (Port 5000)
    │                        │
    │                        ▼
    │                   MongoDB (Port 27017)
    │                   + PersistentVolume
    │
    └──► /*  ────► React Frontend (Port 80)
```

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Frontend | React 18, Nginx |
| Backend | Node.js, Express, Mongoose |
| Database | MongoDB 6.0 |
| Container | Docker |
| Orchestration | Kubernetes (AWS EKS 1.29) |
| IaC | Terraform |
| CI/CD | Jenkins |
| GitOps | ArgoCD |
| Ingress | AWS Load Balancer Controller |
| Security Scan | Trivy |

## 📁 Project Structure

```
three-tier-eks-project/
├── Application-Code/
│   ├── backend/          # Node.js Express API
│   └── frontend/         # React app
├── terraform/
│   ├── eks-cluster/      # EKS + VPC + Nodes
│   └── jenkins-server/   # Jenkins EC2 instance
├── k8s_manifests/
│   ├── namespace.yaml
│   ├── mongo/            # MongoDB + PVC + Secret
│   ├── backend/          # Backend Deployment + Service
│   ├── frontend/         # Frontend Deployment + Service
│   ├── ingress/          # AWS ALB Ingress
│   ├── hpa.yaml          # Auto-scaling
│   └── argocd-app.yaml   # ArgoCD Application
└── jenkins/
    ├── Jenkinsfile-backend
    └── Jenkinsfile-frontend
```

## 🚀 Quick Start

### 1. Before you begin
- AWS account with IAM user (`eks-admin` with AdministratorAccess)
- DockerHub account
- GitHub account
- MacBook with: `brew install awscli terraform kubectl eksctl helm`

### 2. Update your usernames
Search and replace `YOUR_DOCKERHUB_USERNAME` and `kalpsoni18` in:
- `k8s_manifests/backend/deploy.yaml`
- `k8s_manifests/frontend/deploy.yaml`
- `jenkins/Jenkinsfile-backend`
- `jenkins/Jenkinsfile-frontend`
- `k8s_manifests/argocd-app.yaml`

### 3. Deploy Jenkins
```bash
cd terraform/jenkins-server
terraform init && terraform apply --auto-approve
```

### 4. Deploy EKS Cluster
```bash
cd terraform/eks-cluster
terraform init && terraform apply --auto-approve
aws eks update-kubeconfig --region us-west-2 --name taskflow-cluster
```

### 5. Deploy Application
```bash
kubectl apply -f k8s_manifests/namespace.yaml
kubectl apply -f k8s_manifests/mongo/
kubectl apply -f k8s_manifests/backend/
kubectl apply -f k8s_manifests/frontend/
kubectl apply -f k8s_manifests/ingress/
```

### 6. Get your app URL
```bash
kubectl get ingress -n taskflow
```

## 💰 Estimated AWS Cost
- EKS Control Plane: ~$2.40/day
- 2x t3.medium nodes: ~$2.00/day  
- NAT Gateway: ~$1.00/day
- **Total: ~$5-6/day**

> ⚠️ Run `terraform destroy` in both terraform folders when done to avoid charges!

## 🧹 Cleanup
```bash
kubectl delete namespace taskflow argocd
cd terraform/eks-cluster && terraform destroy --auto-approve
cd terraform/jenkins-server && terraform destroy --auto-approve
```
