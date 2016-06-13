#!/usr/bin/env bash

# download zookeeper 
sudo wget --quiet  http://apache.claz.org/zookeeper/zookeeper-3.5.1-alpha/zookeeper-3.5.1-alpha.tar.gz 
#wget --quiet  http://apache.claz.org/zookeeper/zookeeper-3.5.1-alpha/zookeeper-3.5.1-alpha.tar.gz


sudo mkdir /opt/zookeeper

sudo  tar -zxvf zookeeper-3.5.1-alpha.tar.gz --strip-components 1  -C /opt/zookeeper/

# create conf file 
sudo cp  /opt/zookeeper/conf/zoo_sample.cfg  /opt/zookeeper/conf/zoo.cfg

# start zookeeper
sudo /opt/zookeeper/bin/zkServer.sh   start














