#!/bin/bash
apt update -y
apt install -y nginx curl
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
echo "<html><body><h1>Instance ID: $INSTANCE_ID</h1></body></html>" > /var/www/html/index.nginx-debian.html
systemctl restart nginx
