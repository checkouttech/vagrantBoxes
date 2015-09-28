#!/usr/bin/env bash

# install bottle ( can be moved into package ) 
sudo pip install bottle

# install requests 
sudo pip install requests


sudo pip install supervisor

sudo pip install python-memcached

# to allow access to supervisor UI from host's browwer 
sudo   echo '0.0.0.0 localhost' >> /etc/hosts

