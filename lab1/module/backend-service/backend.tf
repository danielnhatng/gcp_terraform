resource "google_compute_backend_service" "nhatnd19-backend" {
  name                 = "nhatnd19-backend"
  project = var.project_name
  protocol             = "HTTP"
  port_name            = "http"

  health_checks = [var.backend_healthcheck]
  enable_cdn = false
  load_balancing_scheme = "EXTERNAL_MANAGED"
  locality_lb_policy = "ROUND_ROBIN"
  session_affinity = "NONE"
  log_config {
    enable = false
  }
  timeout_sec      = 30
  # security_policy = "projects/learning-cloud-with-fpt/global/securityPolicies/default-security-policy-for-backend-service-nhatnd19-backend"
  backend {
    balancing_mode    = "UTILIZATION"
    capacity_scaler  = 1
    # have to use instanceGroups instead of instanceGroupManagers
    group            = "projects/learning-cloud-with-fpt/zones/asia-east2-b/instanceGroups/nhatnd19-instance-group"
    max_utilization  = 0.8
  }
}
