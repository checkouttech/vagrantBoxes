#!/usr/bin/env bash

# install nodejs and npm 
sudo yum -y install epel-release
sudo yum -y install nodejs
sudo yum -y install npm

# install pivot 
npm i -g imply-pivot

# run pivot and connect to druid running on host machine 
# pivot --druid 10.0.2.2:8082

# TODO how to run it in daemon mode




# download metabase 
wget --quiet  http://downloads.metabase.com/v0.18.1/metabase.jar



#####################################################
############## example
#####################################################
#

# Dashboard
# http://http://192.168.150.110:9090/



