#!/usr/bin/env bash
echo "Installing Apache..."
yum install -y httpd > /dev/null 2>&1
echo "Starting Apache..."
systemctl start httpd
echo "Coping files..."
cp -r /vagrant/html/* /var/www/html