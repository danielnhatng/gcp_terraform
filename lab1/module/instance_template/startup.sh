#!bin/bash
apt-get update
apt-get install -y apache2
systemctl start apache2
INTERNAL_IP=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip)
echo "Hello from $HOSTNAME with IP: $INTERNAL_IP" > /var/www/html/index.html
sudo systemctl restart nginx