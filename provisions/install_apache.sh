#!/usr/bin/env bash

apt-get update
apt-get install -y apache2

sudo yum install httpd


if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

sudo service httpd start


# Install apache ( without prompt )  
sudo yum -y install httpd

# Start apache 
sudo systemctl start httpd.service

# Disable firewall 
sudo systemctl stop firewalld




# centos 
# sudo yum install httpd
# sudo systemctl start httpd.service

## To deploy apache 

# sudo yum install httpd
# sudo service httpd start



