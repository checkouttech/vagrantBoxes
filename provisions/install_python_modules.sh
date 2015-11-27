#!/usr/bin/env bash

# install bottle ( can be moved into package ) 
sudo pip install bottle

# install requests 
sudo pip install requests

sudo pip install statsd

sudo pip install supervisor

sudo pip install python-memcached

wget http://cbs.centos.org/kojifiles/packages/python-six/1.9.0/1.el7/noarch/python-six-1.9.0-1.el7.noarch.rpm

sudo yum install -y python-six-1.9.0-1.el7.noarch.rpm

sudo pip install yaml

sudo  pip install pyyaml

sudo  pip install memcache

sudo pip install -U pytest

sudo pip install pytest-sugar




