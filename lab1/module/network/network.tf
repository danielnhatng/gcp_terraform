resource "google_compute_network" "vpc_network" {
    name                    = "nhatnd19-vpc"  
    description             = "my vpc"
    project                 = var.project_name
    auto_create_subnetworks = false
    routing_mode = "REGIONAL"
}

resource "google_compute_subnetwork" "subnetwork1" {
    name          = "nhatnd19-vpc-asia-east2" 
    ip_cidr_range = "10.170.0.0/20"  
    region        = "asia-east2"  
    network       = google_compute_network.vpc_network.self_link
    description   = "my subnet"
    private_ip_google_access = false
    stack_type = "IPV4_ONLY"
}

resource "google_compute_firewall" "nhatnd19-allow-internal" {
    name    = "nhatnd19-allow-internal"
    network = google_compute_network.vpc_network.self_link
    direction = "INGRESS"

    allow {
        protocol = "tcp"
        ports = [ 22 , 80, 443]
    }

    source_ranges = ["10.170.0.0/20"] 

    priority = 1000

}

resource "google_compute_firewall" "nhatnd19-allow-healthcheck" {
    name    = "nhatnd19-allow-healthcheck"
    network = google_compute_network.vpc_network.self_link
    direction = "INGRESS"

    allow {
        protocol = "tcp"
        ports = [80]
    }

    source_ranges = ["35.191.0.0/16", "130.211.0.0/22"] 
    priority = 1000
}

resource "google_compute_firewall" "nhatnd19-allow-ssh" {
    name    = "nhatnd19-allow-ssh"
    network = google_compute_network.vpc_network.self_link
    direction = "INGRESS"

    allow {
        protocol = "tcp"
        ports = [ 22 ]
    }

    source_ranges = ["35.235.240.0/20"] 

    priority = 1000

}