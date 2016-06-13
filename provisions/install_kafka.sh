#!/usr/bin/env bash

# download kafka 
wget --quiet http://apache.claz.org/kafka/0.10.0.0/kafka_2.11-0.10.0.0.tgz
#wget --quiet http://www.mirrorservice.org/sites/ftp.apache.org/kafka/0.8.1.1/kafka-0.8.1.1-src.tgz 

# working one 
# [vagrant@data ~]$ wget "http://mirror.cc.columbia.edu/pub/software/apache/kafka/0.8.2.1/kafka_2.11-0.8.2.1.tgz"
# //apache.claz.org/kafka/0.10.0.0/kafka_2.11-0.10.0.0.tgz fast and latest  

sudo mkdir /opt/kafka

sudo  tar -zxvf kafka_2.11-0.10.0.0.tgz --strip-components 1  -C /opt/kafka/


# start kafka and connect to zookeeper
sudo /opt/kafka/bin/kafka-server-start.sh  /opt/kafka/config/server.properties


#export KAFKA_HOME=/opt/kafka/
#export KAFKA=$KAFKA_HOME/bin
#export KAFKA_CONFIG=$KAFKA_HOME/config

#sudo $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties

