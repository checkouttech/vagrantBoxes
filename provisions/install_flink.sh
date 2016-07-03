#!/usr/bin/env bash

# download flink
wget --quiet  http://apache.claz.org/flink/flink-1.0.3/flink-1.0.3-bin-hadoop27-scala_2.11.tgz


export FLINK_HOME=/opt/flink/
export FLINK=$FLINK_HOME/bin
export FLINK_CONFIG=$FLINK_HOME/conf


#write to environment file for all future sessions
sudo /bin/sh -c 'echo export FLINK_HOME="/opt/flink/" >> /etc/environment'
sudo /bin/sh -c 'echo export FLINK="$FLINK_HOME/bin" >> /etc/environment'
sudo /bin/sh -c 'echo export FLINK_CONF="$FLINK_HOME/conf" >> /etc/environment'


#sudo mkdir /opt/flink
sudo mkdir $FLINK_HOME

sudo  tar -zxvf flink-1.0.3-bin-hadoop27-scala_2.11.tgz  --strip-components 1  -C $FLINK_HOME


####################################################
######## start flink daemon
####################################################

#sudo $KAFKA/kafka-server-start.sh  -daemon  $KAFKA_CONFIG/server_1.properties
#sudo $KAFKA/kafka-server-start.sh  -daemon  $KAFKA_CONFIG/server_2.properties
sudo $FLINK/start-local.sh


####################################################
############# example 
####################################################

#sudo /opt/flink/bin/flink  run  /opt/flink/examples/streaming/Kafka.jar   --topic my-topic3  --bootstrap.servers 192.168.150.80:9092   --group.id  abc   --zookeeper.connect  192.168.150.70:2181
#tail -f /opt/flink/log//flink-*-jobmanager-*.out


####################################################
############# get libs 
####################################################

# get zookeeper libs
#wget --quiet https://repo1.maven.org/maven2/org/apache/zookeeper/zookeeper/3.4.8/zookeeper-3.4.8.jar
#sudo cp zookeeper-3.4.8.jar $FLUME_HOME/lib/


####################################################
############# config settings
####################################################


####################################################
#### Restrict Java heap space to avoid overflowing limited free RAM 
#### Else not all broker will get initialized 
####################################################

#write to environment file for all future sessions 
#sudo /bin/sh -c 'echo export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M" >> /etc/environment'

#export for the current session before starting kafka cluster 
#export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"


