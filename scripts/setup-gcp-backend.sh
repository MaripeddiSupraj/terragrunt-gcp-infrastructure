#!/bin/bash
set -e

PROJECT_ID=${1}
ENVIRONMENT=${2}
REGION=${3:-us-central1}

if [[ -z "$PROJECT_ID" || -z "$ENVIRONMENT" ]]; then
    echo "Usage: $0 <project-id> <environment> [region]"
    exit 1
fi

BUCKET_NAME="ecommerce-terraform-state-${PROJECT_ID}-${ENVIRONMENT}"

echo "🔧 Setting up GCS backend for $ENVIRONMENT..."

gsutil mb -p "$PROJECT_ID" -c STANDARD -l "$REGION" "gs://$BUCKET_NAME" || true
gsutil versioning set on "gs://$BUCKET_NAME"

echo "✅ GCS backend setup completed!"
echo "Bucket: gs://$BUCKET_NAME"