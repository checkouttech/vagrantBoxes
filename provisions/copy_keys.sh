#!/usr/bin/env bash

# copy prodicion user keys from /tmp/ssh_keys directory to .ssh/ folder
sudo ls -lR /tmp/

#sudo mkdir -p /home/prodicon/.ssh
#sudo chmod 700  /home/prodicon/.ssh

# add keys 
#cp ssh_keys/*  /home/prodicon/.ssh/

sudo -u prodicon mkdir -p /home/prodicon/.ssh
sudo chmod 700  /home/prodicon/.ssh
sudo chown prodicon:prodicon /home/prodicon/.ssh

sudo cp  /tmp/ssh_keys/id_rsa  /home/prodicon/.ssh/
sudo chmod 600 -R  /home/prodicon/.ssh/id_rsa
sudo chown prodicon:prodicon /home/prodicon/.ssh/id_rsa

sudo cp  /tmp/ssh_keys/id_rsa.pub  /home/prodicon/.ssh/
sudo chmod 644 -R  /home/prodicon/.ssh/id_rsa.pub
sudo chown prodicon:prodicon /home/prodicon/.ssh/id_rsa.pub

sudo cp  /tmp/ssh_keys/authorized_keys  /home/prodicon/.ssh/
sudo chmod 600 -R  /home/prodicon/.ssh/authorized_keys
sudo chown prodicon:prodicon /home/prodicon/.ssh/authorized_keys


## add keys 
##cp ssh_keys/*  /home/prodicon/.ssh/

#sudo mkdir -p /home/prodicon/.ssh
#sudo chmod 700  /home/prodicon/.ssh

##sudo chown -R prodicon:vagrant /home/prodicon/.ssh
##sudo cp /vagrant/ssh_keys/id_rsa*  /home/prodicon/.ssh/
##sudo chmod 644 -R  /home/prodicon/.ssh/id_rsa.pub
##sudo chmod 600 -R  /home/prodicon/.ssh/id_rsa

#To source bin/bash , instead of /bin/sh
#sudo chsh -s /bin/bash

#sudo chsh -s /bin/bash <prodicon>
#useradd -m -s /bin/bash <userName>




