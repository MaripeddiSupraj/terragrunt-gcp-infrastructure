# Terragrunt GCP Infrastructure

Production-ready Terragrunt setup for multi-environment GCP 3-tier applications.

## 🚀 Quick Start

```bash
# Setup GCS backend
./scripts/setup-gcp-backend.sh your-project-id dev us-central1

# Deploy development environment
./scripts/deploy-environment.sh dev all

# Deploy specific component
./scripts/deploy-environment.sh prod gke
```

## 📁 Structure

- `_envcommon/` - Common configurations across environments
- `modules/` - Terraform modules for GCP resources
- `environments/` - Environment-specific configurations (dev/staging/prod)
- `scripts/` - Deployment and management scripts

## 🎯 Features

- ✅ Multi-environment support (dev/staging/prod)
- ✅ 3-tier application architecture
- ✅ GKE cluster with autoscaling
- ✅ Cloud SQL with high availability
- ✅ Load balancer with SSL
- ✅ Monitoring and logging
- ✅ Cost optimization
- ✅ Security best practices

## 📋 Prerequisites

- Terraform >= 1.0
- Terragrunt >= 0.45
- Google Cloud CLI
- GitHub CLI (optional)

## 🔧 Configuration

1. Update `environments/*/organization.hcl` with your GCP organization details
2. Update `environments/*/env.hcl` with your project IDs
3. Run setup script to create GCS backend
4. Deploy environments using provided scripts

## 📖 Documentation

See individual module README files for detailed configuration options.