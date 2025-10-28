include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules/gke-workload"
}

dependency "gke" {
  config_path = "../../gke-cluster"
  mock_outputs = {
    cluster_name = "mock-cluster"
    cluster_endpoint = "https://mock-endpoint"
  }
}

dependency "static_ip" {
  config_path = "../../static-ip"
  mock_outputs = {
    ip_name = "mock-ip"
    ip_address = "1.2.3.4"
  }
}

inputs = {
  app_name  = "frontend"
  namespace = "ecommerce-dev"
  image     = "gcr.io/google-samples/hello-app:1.0"
  port      = 8080
  replicas  = 1
  
  resources = {
    requests = {
      cpu    = "100m"
      memory = "128Mi"
    }
    limits = {
      cpu    = "500m"
      memory = "512Mi"
    }
  }
  
  env_vars = {
    PORT = "8080"
    MESSAGE = "Hello from ${local.env_vars.locals.environment} environment!"
  }
  
  health_check = {
    path                  = "/"
    port                  = 8080
    initial_delay_seconds = 30
    period_seconds        = 10
  }
  
  create_ingress  = true
  static_ip_name  = dependency.static_ip.outputs.ip_name
}