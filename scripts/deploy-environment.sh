#!/bin/bash
set -e

ENVIRONMENT=${1:-dev}
COMPONENT=${2:-all}

echo "🚀 Deploying $ENVIRONMENT environment..."

if [[ -z "$GOOGLE_APPLICATION_CREDENTIALS" ]]; then
    echo "❌ GOOGLE_APPLICATION_CREDENTIALS not set"
    exit 1
fi

cd "environments/$ENVIRONMENT"

case $COMPONENT in
    "all")
        echo "📦 Deploying all components..."
        terragrunt run-all plan
        read -p "Continue with apply? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            terragrunt run-all apply
        fi
        ;;
    "project")
        echo "📦 Deploying project..."
        cd project && terragrunt apply
        ;;
    "networking")
        echo "🌐 Deploying networking..."
        cd networking && terragrunt apply
        ;;
    "gke")
        echo "☸️ Deploying GKE cluster..."
        cd gke-cluster && terragrunt apply
        ;;
    "database")
        echo "🗄️ Deploying database..."
        cd database && terragrunt apply
        ;;
    *)
        echo "❌ Unknown component: $COMPONENT"
        echo "Available: all, project, networking, gke, database"
        exit 1
        ;;
esac

echo "✅ Deployment completed!"