resource "kubernetes_namespace" "app" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "app" {
  metadata {
    name      = var.app_name
    namespace = kubernetes_namespace.app.metadata[0].name
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          image = var.image
          name  = var.app_name
          port {
            container_port = var.port
          }

          dynamic "env" {
            for_each = var.env_vars
            content {
              name  = env.key
              value = env.value
            }
          }

          resources {
            limits = var.resources.limits
            requests = var.resources.requests
          }

          liveness_probe {
            http_get {
              path = var.health_check.path
              port = var.health_check.port
            }
            initial_delay_seconds = var.health_check.initial_delay_seconds
            period_seconds        = var.health_check.period_seconds
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name      = var.app_name
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  spec {
    selector = {
      app = var.app_name
    }

    port {
      port        = 80
      target_port = var.port
    }

    type = var.service_type
  }
}

resource "kubernetes_ingress_v1" "app" {
  count = var.create_ingress ? 1 : 0
  
  metadata {
    name      = "${var.app_name}-ingress"
    namespace = kubernetes_namespace.app.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class"                = "gce"
      "kubernetes.io/ingress.global-static-ip-name" = var.static_ip_name
    }
  }

  spec {
    rule {
      http {
        path {
          path      = "/*"
          path_type = "ImplementationSpecific"
          backend {
            service {
              name = kubernetes_service.app.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}