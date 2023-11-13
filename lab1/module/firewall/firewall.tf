resource "google_compute_firewall" "nhatnd19-deny-internet" {
  name    = "nhatnd19-deny-internet"
  network = "terraform-network" 

  allow {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"] # Deny all traffic

  priority = 1000 
}

resource "google_compute_firewall" "terraform-allow-internal" {
  name    = "terraform-allow-internal"
  network = "terraform-network" 
  

  allow {
    protocol = "all"
  }

  source_ranges = ["10.170.0.0/20"] # Allow traffic from the specific IP range of your subnetwork

  priority = 900 

}
