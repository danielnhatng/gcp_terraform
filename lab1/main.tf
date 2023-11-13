terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.5.0"
    }
  }
}

provider "google" {
  credentials = file("learning-cloud-with-fpt-754e9a8d8687.json")
  project = "learning-cloud-with-fpt"
}




module "network" {
  source = "./module/network"
  project_name = var.project_name
}

module "static_ip" {
  source = "./module/static_ip"
}

module "instance_template" {
  source = "./module/instance_template"
  subnet_link = module.network.subnet_link
  network_link = module.network.network_link
  depends_on = [ module.network]
}

module "instance_group" {
  source = "./module/instance_group"
  template_link = module.instance_template.template_link
  depends_on = [ module.instance_template ]
}

module "healthcheck" {
  source = "./module/healthcheck"
}
module "backend" {
  source = "./module/backend-service"
  backend_healthcheck = module.healthcheck.id
  project_name = var.project_name
  depends_on = [ module.instance_group , module.healthcheck]
}


#  load_balancer
module "forwardingrules" {
  source = "./module/forwardingrules"
  project_name = var.project_name
  backend_url = module.backend.backend_url
  depends_on = [ module.backend , module.static_ip]
  static_ip = module.static_ip.static_ip_address
}

module "alert-policy" {
  source = "./module/alert-policy"
}