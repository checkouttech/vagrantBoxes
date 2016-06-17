#!/usr/bin/env bash

# download kafka 
wget --quiet http://apache.claz.org/kafka/0.10.0.0/kafka_2.11-0.10.0.0.tgz

export KAFKA_HOME=/opt/kafka/
export KAFKA=$KAFKA_HOME/bin
export KAFKA_CONFIG=$KAFKA_HOME/config

#sudo mkdir /opt/kafka
sudo mkdir $KAFKA_HOME

#sudo  tar -zxvf kafka_2.11-0.10.0.0.tgz --strip-components 1  -C /opt/kafka/
sudo  tar -zxvf kafka_2.11-0.10.0.0.tgz --strip-components 1  -C $KAFKA_HOME

####################################################
############# broker 1 specific settings
####################################################

## copy standard issued server properties file as template for broker 1  
sudo cp $KAFKA_CONFIG/server.properties  $KAFKA_CONFIG/server_1.properties

## set broker ID
export TARGET_KEY=broker.id
export REPLACEMENT_VALUE=1

sudo sed -c -i "s/\($TARGET_KEY*=*\).*/\1$REPLACEMENT_VALUE/" $KAFKA_CONFIG/server_1.properties

## set listerner
export TARGET_KEY=listeners
export REPLACEMENT_VALUE=PLAINTEXT:\\/\\/192.168.150.80:9092

sudo sed -c -i "s/#\($TARGET_KEY*=*\).*/\1$REPLACEMENT_VALUE/" $KAFKA_CONFIG/server_1.properties

## set advertised.listener
export TARGET_KEY=advertised.listeners
export REPLACEMENT_VALUE=PLAINTEXT:\\/\\/192.168.150.80:9092

sed -c -i "s/#\($TARGET_KEY*=*\).*/\1$REPLACEMENT_VALUE/" $KAFKA_CONFIG/server_1.properties


## set log directory
export TARGET_KEY=log.dirs
export REPLACEMENT_VALUE=\\/tmp\\/broker1\\/log

sudo sed -c -i "s/\($TARGET_KEY*=*\).*/\1$REPLACEMENT_VALUE/" $KAFKA_CONFIG/server_1.properties

# set remote zookeeper
export TARGET_KEY=zookeeper.connect
export REPLACEMENT_VALUE=192.168.150.70:2181
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $KAFKA_CONFIG/server_1.properties


####################################################
######## broker 2 specific settings
####################################################


## copy standard issued server properties file as template for broker 2 
sudo cp $KAFKA_CONFIG/server.properties  $KAFKA_CONFIG/server_2.properties


## set broker ID
export TARGET_KEY=broker.id
export REPLACEMENT_VALUE=2

sudo sed -c -i "s/\($TARGET_KEY*=*\).*/\1$REPLACEMENT_VALUE/" $KAFKA_CONFIG/server_2.properties

## set listerner
export TARGET_KEY=listeners
export REPLACEMENT_VALUE=PLAINTEXT:\\/\\/192.168.150.80:9093

sudo sed -c -i "s/#\($TARGET_KEY*=*\).*/\1$REPLACEMENT_VALUE/" $KAFKA_CONFIG/server_2.properties

## set advertised.listener
export TARGET_KEY=advertised.listeners
export REPLACEMENT_VALUE=PLAINTEXT:\\/\\/192.168.150.80:9093

sed -c -i "s/#\($TARGET_KEY*=*\).*/\1$REPLACEMENT_VALUE/" $KAFKA_CONFIG/server_2.properties


## set log directory
export TARGET_KEY=log.dirs
export REPLACEMENT_VALUE=\\/tmp\\/broker2\\/log

sudo sed -c -i "s/\($TARGET_KEY*=*\).*/\1$REPLACEMENT_VALUE/" $KAFKA_CONFIG/server_2.properties


# set remote zookeeper
export TARGET_KEY=zookeeper.connect
export REPLACEMENT_VALUE=192.168.150.70:2181
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $KAFKA_CONFIG/server_2.properties



####################################################
######## start kafka brokers and connect to zookeper
####################################################

sudo $KAFKA/kafka-server-start.sh  -daemon  $KAFKA_CONFIG/server_1.properties
sudo $KAFKA/kafka-server-start.sh  -daemon  $KAFKA_CONFIG/server_2.properties


#sudo $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties

# config remote zookeeper 
#export TARGET_KEY=zookeeper.connect
#export REPLACEMENT_VALUE=192.168.150.70:2181
#sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"  /opt/kafka/config/server.properties
#sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $KAFKA_CONFIG/server_1.properties   $KAFKA_CONFIG/server_2.properties



#sudo $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties

# accept message receiving from remote servers 
#export TARGET_KEY=advertised.listeners
#export REPLACEMENT_VALUE=PLAINTEXT:\\/\\/192.168.150.80:9092

#sed -c -i "s/#\($TARGET_KEY*=*\).*/\1$REPLACEMENT_VALUE/" /opt/kafka/config/server.properties



# start kafka and connect to zookeeper
#sudo /opt/kafka/bin/kafka-server-start.sh  -daemon  /opt/kafka/config/server.properties

# kafka-server-start.sh ${KAFKA_HOME}/config/server1.properties   
#  kafka-server-start.sh ${KAFKA_HOME}/config/server2.properties  


# create 2 server properties files for 2 brokers 
#sudo cp $KAFKA_CONFIG/server.properties  $KAFKA_CONFIG/server_1.properties
#sudo cp $KAFKA_CONFIG/server.properties  $KAFKA_CONFIG/server_2.properties


