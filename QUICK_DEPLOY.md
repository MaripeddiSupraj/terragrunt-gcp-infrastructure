# Quick Manual Deployment

Since we're hitting permission issues with Terraform, here's how to deploy manually:

## 1. Enable APIs (in GCP Console)
```
Go to: https://console.cloud.google.com/apis/library
Enable these APIs:
- Compute Engine API
- Kubernetes Engine API
```

## 2. Create GKE Cluster (via gcloud)
```bash
gcloud container clusters create demo-cluster \
  --zone=us-central1-a \
  --machine-type=e2-micro \
  --num-nodes=1 \
  --enable-autoscaling \
  --min-nodes=1 \
  --max-nodes=3
```

## 3. Deploy Demo App
```bash
# Get cluster credentials
gcloud container clusters get-credentials demo-cluster --zone=us-central1-a

# Deploy hello app
kubectl create deployment hello-app --image=gcr.io/google-samples/hello-app:1.0
kubectl expose deployment hello-app --type=LoadBalancer --port=80 --target-port=8080

# Get external IP
kubectl get service hello-app
```

## 4. Access Your App
```bash
# Wait for external IP (takes 2-3 minutes)
kubectl get service hello-app --watch

# Once you see EXTERNAL-IP, open in browser:
# http://EXTERNAL_IP
```

## Expected Result
You'll see: "Hello, World!" with version and hostname info.

## Cleanup
```bash
kubectl delete service hello-app
kubectl delete deployment hello-app
gcloud container clusters delete demo-cluster --zone=us-central1-a
```

This gives you a working 3-tier demo without complex Terragrunt setup!