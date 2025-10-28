# Demo Application Access

## 🌐 What Gets Deployed

When you deploy this infrastructure, you'll get:

### Frontend Application
- **Google Hello App** - Simple web application
- **Accessible via browser** at the external IP
- **Shows environment info** (dev/staging/prod)
- **Auto-scaling** based on CPU usage

### Backend Services
- **Node.js API** - Backend service (internal)
- **Python Worker** - Background processing (internal)
- **PostgreSQL Database** - Data storage (private)

## 🚀 Access Your Application

After deployment completes:

1. **Get the external IP:**
```bash
cd environments/dev/static-ip
terragrunt output ip_address
```

2. **Open in browser:**
```
http://YOUR_EXTERNAL_IP
```

3. **You should see:**
```
Hello, World!
Version: 1.0.0
Hostname: frontend-xxx-xxx
```

## 🔍 Verify Deployment

```bash
# Check GKE cluster
kubectl get nodes

# Check applications
kubectl get pods -n ecommerce-dev

# Check services
kubectl get svc -n ecommerce-dev

# Check ingress
kubectl get ingress -n ecommerce-dev
```

## 📊 What You'll See

- ✅ **Working web application** accessible from internet
- ✅ **GKE cluster** with auto-scaling nodes
- ✅ **PostgreSQL database** (private, not web accessible)
- ✅ **Load balancer** with external IP
- ✅ **Multi-tier architecture** properly connected

Perfect for demonstrating a complete 3-tier application on GCP! 🎉