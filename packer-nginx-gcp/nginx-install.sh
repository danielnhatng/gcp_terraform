#!/bin/bash

set -e

# Update packages
apt-get update

# Install nginx
apt-get install -y nginx

# Sample config 
echo "Hello from Packer!" > /var/www/html/index.nginx-debian.html

# Start nginx service
systemctl start nginx

# Enable on boot 
systemctl enable nginx