# Quick Setup

## 1. GCP Setup
```bash
# Create service accounts
gcloud iam service-accounts create terragrunt-dev-sa --project=your-dev-project
gcloud iam service-accounts create terragrunt-prod-sa --project=your-prod-project

# Grant permissions
gcloud projects add-iam-policy-binding your-dev-project \
  --member="serviceAccount:terragrunt-dev-sa@your-dev-project.iam.gserviceaccount.com" \
  --role="roles/editor"

gcloud projects add-iam-policy-binding your-prod-project \
  --member="serviceAccount:terragrunt-prod-sa@your-prod-project.iam.gserviceaccount.com" \
  --role="roles/editor"

# Create keys
gcloud iam service-accounts keys create dev-key.json \
  --iam-account=terragrunt-dev-sa@your-dev-project.iam.gserviceaccount.com

gcloud iam service-accounts keys create prod-key.json \
  --iam-account=terragrunt-prod-sa@your-prod-project.iam.gserviceaccount.com
```

## 2. GitHub Secrets
Add these to GitHub Settings → Secrets:
- `GCP_SA_KEY_DEV`: Base64 encoded dev-key.json
- `GCP_SA_KEY_PROD`: Base64 encoded prod-key.json

## 3. Update Config
Edit `environments/*/env.hcl` with your project IDs

## 4. Test
```bash
# Create develop branch
git checkout -b develop
git push origin develop

# Make a change and push to trigger workflow
echo '# test' >> README.md
git add . && git commit -m "test" && git push
```

That's it! 🚀