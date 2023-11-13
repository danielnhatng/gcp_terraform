resource "google_compute_disk" "nhatnd19-disk" {
  name   = "nhatnd19-disk"
  zone = "asia-east2-b"

  size = "50"

  type = "pd-balanced"
}
