# Define a Google Compute Engine instance template
resource "google_compute_instance_template" "my_instance_template" {
  name         = "my-instance-template"
  description  = "Instance template with Apache"
  machine_type = "e2-micro"
  disk {
    auto_delete  = false
    boot         = true
    source_image = "projects/learning-cloud-with-fpt/global/images/ubuntu-nginx-image"
  }
  # disk {
  #   auto_delete = false
  #   boot = false
  #   source = "nhatnd19-disk"
  # }
  metadata = {
    startup-script = <<-EOF
      #!/bin/bash
      apt-get update
      apt-get install -y apache2
      systemctl start apache2
    EOF
  }
  network_interface {
    network = var.network_link
    subnetwork = var.subnet_link
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }



}
