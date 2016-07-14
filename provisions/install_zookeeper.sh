#!/usr/bin/env bash

# download zookeeper
sudo wget --quiet  http://apache.claz.org/zookeeper/zookeeper-3.5.1-alpha/zookeeper-3.5.1-alpha.tar.gz
#wget --quiet  http://apache.claz.org/zookeeper/zookeeper-3.5.1-alpha/zookeeper-3.5.1-alpha.tar.gz


export ZOOKEEPER_HOME=/opt/zookeeper/
export ZOOKEEPER=$ZOOKEEPER_HOME/bin
export ZOOKEEPER_CONFIG=$ZOOKEEPER_HOME/conf


#write to environment file for all future sessions
sudo /bin/sh -c 'echo export ZOOKEEPER_HOME="/opt/zookeeper/" >> /etc/environment'
sudo /bin/sh -c 'echo export ZOOKEEPER="$ZOOKEEPER_HOME/bin" >> /etc/environment'
sudo /bin/sh -c 'echo export ZOOKEEPER_CONF="$ZOOKEEPER_HOME/conf" >> /etc/environment'


sudo mkdir /opt/zookeeper

sudo  tar -zxvf zookeeper-3.5.1-alpha.tar.gz --strip-components 1  -C $ZOOKEEPER_HOME

# create conf file
sudo cp  /opt/zookeeper/conf/zoo_sample.cfg  /opt/zookeeper/conf/zoo.cfg

# start zookeeper
sudo /opt/zookeeper/bin/zkServer.sh   start


####################################################
######## examples
####################################################

# zookeeper status
#
#   /opt/zookeeper/bin/zkServer.sh   status
#
## zookeeper stop
#
#   /opt/zookeeper/bin/zkServer.sh   stop
#
# connect to remote zookeeper
#
#   /opt/zookeeper/bin/zkCli.sh connect localhost:2181 ???
#   /opt/zookeeper/bin/zkCli.sh -server  localhost:2181

#










