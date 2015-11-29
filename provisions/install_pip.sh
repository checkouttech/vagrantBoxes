#!/usr/bin/env bash

# install the EPEL repository
sudo rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

# check for update 
#sudo yum -y update

# install python-pip
sudo yum -y install python-pip


# pip install -U setuptools
# pip install -U pip

