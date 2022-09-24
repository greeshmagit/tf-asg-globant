#!/bin/bash
yum update -y
yum install httpd -y
mkdir -p /var/www/html
chown -R $ ec2-user:$ ec2-user /var/www/html
chmod -R 755 /var/www
echo 'welcome appache' >> /var/www/html/index.html
service httpd start
chkconfig httpd on

