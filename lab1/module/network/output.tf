output "subnet_link" {
    value = google_compute_subnetwork.subnetwork1.self_link
}

output "network_link" {
    value = google_compute_network.vpc_network.self_link
}   