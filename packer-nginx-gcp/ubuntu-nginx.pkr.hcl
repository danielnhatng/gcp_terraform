packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
  }
}

source "googlecompute" "ubuntu" {
  account_file     = var.account_file
  image_description = var.image_description
  image_labels = var.image_labels
  image_name          = var.image_name
  project_id          = var.project_id
  source_image_family = var.source_image_family
  ssh_username        = var.ssh_username
  zone                = var.zone

  subnetwork = "default"  # Replace with your network name

  
}

build {
  name = "packer"
  sources = ["source.googlecompute.ubuntu"]

  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "echo Installing nginx",
      "sleep 30",
      "sudo apt-get update",
      "sudo apt-get install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "sudo ufw allow proto tcp from any to any port 22,80,443",
      "sudo apt-get install stress-ng -y",
      "echo 'y' | sudo ufw enable",
      "echo \"Variable value is $TEMP\" > demo.txt",
      "sudo chmod 777 /var/www/html/index.html",
      "echo \"Hello world from $(hostname) with NhatND19\" > /var/www/html/index.html"
    ]

  }

}
