resource "google_compute_instance_group_manager" "nhatnd19-instance_group" {
  name = "nhatnd19-instance-group"
  base_instance_name = "nhatnd19-instance-group"
  zone = "asia-east2-b"

  version {
    # instance_template = "projects/learning-cloud-with-fpt/global/instanceTemplates/my-instance-template"
    instance_template = var.template_link
  }
  named_port {
    name = "http"
    port = 80
  }
}

resource "google_compute_autoscaler" "my_autoscaler" {
  name = "nhatnd19-autoscaler"
  target = google_compute_instance_group_manager.nhatnd19-instance_group.self_link
  zone = "asia-east2-b"
  autoscaling_policy {
    max_replicas = 4
    min_replicas = 2
    mode = "ON"

    cpu_utilization {
      target =  0.8
      predictive_method = "NONE"
    }
    load_balancing_utilization {
      target = 0.8
    }

  }
  
}