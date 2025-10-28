# Terragrunt GCP Infrastructure

Production-ready Terragrunt setup for multi-environment GCP 3-tier applications.

## 🚀 Quick Start

### 1. Setup GitHub Actions (Recommended)
```bash
# Follow the setup guide
cat .github/SETUP_GUIDE.md

# Create feature branch
git checkout -b feature/your-feature

# Make changes and create PR
gh pr create --base develop
```

### 2. Manual Deployment (Testing)
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
- GitHub CLI
- GCP Service Accounts with proper permissions
- GitHub repository with Actions enabled

## 🔧 Configuration

1. Update `environments/*/organization.hcl` with your GCP organization details
2. Update `environments/*/env.hcl` with your project IDs
3. Run setup script to create GCS backend
4. Deploy environments using provided scripts

## 📖 Documentation

- [GitHub Actions Setup](.github/SETUP_GUIDE.md) - Complete CI/CD setup
- [Branching Strategy](.github/BRANCH_STRATEGY.md) - Git workflow and deployment process
- [Testing Guide](TESTING_GUIDE.md) - Validation and testing procedures
- Individual module README files for detailed configuration options

## 🔄 Workflow

### Development Process
1. **Feature Branch** → Create from `develop`
2. **Pull Request** → Automated validation and security scan
3. **Code Review** → Manual approval required
4. **Merge to Develop** → Auto-deploy to dev environment
5. **Staging Deployment** → Auto-deploy to staging
6. **Production Release** → Merge to `main` with approval

### Branch Strategy
- `main` → Production deployments
- `develop` → Development and staging deployments
- `feature/*` → New features and changes
- `hotfix/*` → Emergency production fixes

## 🛡️ Security & Compliance

- ✅ Automated security scanning with Checkov
- ✅ Infrastructure drift detection
- ✅ Cost estimation on PRs
- ✅ Branch protection rules
- ✅ Environment-specific approvals
- ✅ Audit logging enabled