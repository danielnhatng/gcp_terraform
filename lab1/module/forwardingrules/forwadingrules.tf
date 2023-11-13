# front-end
resource "google_compute_forwarding_rule" "nhatnd19_forwarding_rules" {
    name = "nhatnd19-frontend"
    ip_protocol = "TCP"
    port_range = 80
    load_balancing_scheme = "EXTERNAL_MANAGED"
    project = var.project_name
    target = google_compute_target_http_proxy.nhatnd19-proxy.self_link
    region = "global"
}

# proxy
resource "google_compute_target_http_proxy" "nhatnd19-proxy" {
    name = "nhatnd19-target-proxy"
    url_map = google_compute_url_map.nhatnd19-url-map.self_link
}

# load balancer
resource "google_compute_url_map" "nhatnd19-url-map" {
    name = "nhatnd19-loadbalancer"
    default_service = var.backend_url #backend serivce url
}