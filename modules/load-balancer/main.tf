resource "google_compute_global_address" "default" {
  name    = "${var.name}-ip"
  project = var.project_id
}

resource "google_compute_managed_ssl_certificate" "default" {
  count = var.enable_ssl ? 1 : 0
  name  = "${var.name}-ssl-cert"
  
  managed {
    domains = var.domains
  }
  
  project = var.project_id
}

resource "google_compute_backend_service" "default" {
  name        = "${var.name}-backend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 30
  project     = var.project_id

  backend {
    group = var.backend_service
  }

  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_health_check" "default" {
  name               = "${var.name}-health-check"
  check_interval_sec = 30
  timeout_sec        = 5
  project            = var.project_id

  http_health_check {
    port         = var.health_check_port
    request_path = var.health_check_path
  }
}

resource "google_compute_url_map" "default" {
  name            = "${var.name}-url-map"
  default_service = google_compute_backend_service.default.id
  project         = var.project_id
}

resource "google_compute_target_https_proxy" "default" {
  count   = var.enable_ssl ? 1 : 0
  name    = "${var.name}-https-proxy"
  url_map = google_compute_url_map.default.id
  ssl_certificates = [
    google_compute_managed_ssl_certificate.default[0].id
  ]
  project = var.project_id
}

resource "google_compute_target_http_proxy" "default" {
  name    = "${var.name}-http-proxy"
  url_map = google_compute_url_map.default.id
  project = var.project_id
}

resource "google_compute_global_forwarding_rule" "https" {
  count      = var.enable_ssl ? 1 : 0
  name       = "${var.name}-https-rule"
  target     = google_compute_target_https_proxy.default[0].id
  port_range = "443"
  ip_address = google_compute_global_address.default.address
  project    = var.project_id
}

resource "google_compute_global_forwarding_rule" "http" {
  name       = "${var.name}-http-rule"
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
  ip_address = google_compute_global_address.default.address
  project    = var.project_id
}