#!/usr/bin/env bash

# download flume
wget --quiet http://apache.claz.org/flume/1.6.0/apache-flume-1.6.0-bin.tar.gz


export FLUME_HOME=/opt/flume/
export FLUME=$FLUME_HOME/bin
export FLUME_CONFIG=$FLUME_HOME/conf


#write to environment file for all future sessions
sudo /bin/sh -c 'echo export FLUME_HOME="/opt/flume/" >> /etc/environment'
sudo /bin/sh -c 'echo export FLUME="$FLUME_HOME/bin" >> /etc/environment'
sudo /bin/sh -c 'echo export FLUME_CONF="$FLUME_HOME/conf" >> /etc/environment'


#sudo mkdir /opt/flume
sudo mkdir $FLUME_HOME

sudo  tar -zxvf apache-flume-1.6.0-bin.tar.gz  --strip-components 1  -C $FLUME_HOME


####################################################
############# get libs 
####################################################

# get zookeeper libs
wget --quiet https://repo1.maven.org/maven2/org/apache/zookeeper/zookeeper/3.4.8/zookeeper-3.4.8.jar
sudo cp zookeeper-3.4.8.jar $FLUME_HOME/lib/






####################################################
############# broker 1 specific settings
####################################################


echo '

flume1.sources = kafka-source-1
flume1.channels = hdfs-channel-1
flume1.sinks = hdfs-sink-1


flume1.sources.kafka-source-1.type = org.apache.flume.source.kafka.KafkaSource
flume1.sources.kafka-source-1.zookeeperConnect = 192.168.150.70:2181
flume1.sources.kafka-source-1.topic = my-topic3
flume1.sources.kafka-source-1.batchSize = 10
flume1.sources.kafka-source-1.channels = hdfs-channel-1


flume1.channels.hdfs-channel-1.type = memory
flume1.channels.hdfs-channel-1.capacity = 10000
flume1.channels.hdfs-channel-1.transactionCapacity = 1000


flume1.sinks.hdfs-sink-1.channel = hdfs-channel-1
flume1.sinks.hdfs-sink-1.type = hdfs
flume1.sinks.hdfs-sink-1.hdfs.writeFormat = Text
flume1.sinks.hdfs-sink-1.hdfs.fileType = DataStream
flume1.sinks.hdfs-sink-1.hdfs.filePrefix = test-events
flume1.sinks.hdfs-sink-1.hdfs.useLocalTimeStamp = true
flume1.sinks.hdfs-sink-1.hdfs.path = /tmp/kafka/%{topic}/%y-%m-%d
flume1.sinks.hdfs-sink-1.hdfs.path =  hdfs://192.168.150.60:9000//user/hadoop
flume1.sinks.hdfs-sink-1.hdfs.rollCount=100
flume1.sinks.hdfs-sink-1.hdfs.rollSize=0

' > $FLUME_CONFIG/kafka2hdfs.conf 



echo '
flume1.sources = kafka-source-1
flume1.channels = c1
flume1.sinks = k1


flume1.sources.kafka-source-1.type = org.apache.flume.source.kafka.KafkaSource
flume1.sources.kafka-source-1.zookeeperConnect = 192.168.150.70:2181
flume1.sources.kafka-source-1.topic = my-topic3
flume1.sources.kafka-source-1.batchSize = 10
flume1.sources.kafka-source-1.channels = c1

flume1.channels.c1.type=memory

flume1.sinks.k1.type=logger
flume1.sinks.k1.channel=c1

flume1.sinks.k1.type = file_roll
flume1.sinks.k1.sink.directory = /data/flume_output

' > $FLUME_CONFIG/kafka2file.conf 


# create output directory 
sudo mkdir -p /data/flume_output
sudo chown vagrant:vagrant /data/flume_output/
sudo chmod 755 -R /data/flume_output


####################################################
#### Restrict Java heap space to avoid overflowing limited free RAM 
#### Else not all broker will get initialized 
####################################################

#write to environment file for all future sessions 
#sudo /bin/sh -c 'echo export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M" >> /etc/environment'

#export for the current session before starting kafka cluster 
#export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"



####################################################
######## start flume daemon
####################################################

#sudo $KAFKA/kafka-server-start.sh  -daemon  $KAFKA_CONFIG/server_1.properties
#sudo $KAFKA/kafka-server-start.sh  -daemon  $KAFKA_CONFIG/server_2.properties

#  /opt/flume/bin/flume-ng   agent --name flume1 -c /opt/flume/conf -f /opt/flume/conf/kafka2file.conf   -Dflume.root.logger=INFO,console -Dflume.log.dir=/tmp -Dflume.log.file=flume-agent.log


####################################################

### copy standard issued server properties file as template for broker 1  
#sudo cp $KAFKA_CONFIG/server.properties  $KAFKA_CONFIG/server_1.properties
#
### set broker ID
#export TARGET_KEY=broker.id
#export REPLACEMENT_VALUE=1
#
#sudo sed -c -i "s/\($TARGET_KEY*=*\).*/\1$REPLACEMENT_VALUE/" $KAFKA_CONFIG/server_1.properties
#
### set listerner
#export TARGET_KEY=listeners
#export REPLACEMENT_VALUE=PLAINTEXT:\\/\\/192.168.150.80:9092
#
#sudo sed -c -i "s/#\($TARGET_KEY*=*\).*/\1$REPLACEMENT_VALUE/" $KAFKA_CONFIG/server_1.properties
#
### set advertised.listener to accept message from remote servers 
#export TARGET_KEY=advertised.listeners
#export REPLACEMENT_VALUE=PLAINTEXT:\\/\\/192.168.150.80:9092
#
#sed -c -i "s/#\($TARGET_KEY*=*\).*/\1$REPLACEMENT_VALUE/" $KAFKA_CONFIG/server_1.properties
#
#
### set log directory
#export TARGET_KEY=log.dirs
#export REPLACEMENT_VALUE=\\/tmp\\/broker1\\/log
#
#sudo sed -c -i "s/\($TARGET_KEY*=*\).*/\1$REPLACEMENT_VALUE/" $KAFKA_CONFIG/server_1.properties
#
## set remote zookeeper
#export TARGET_KEY=zookeeper.connect
#export REPLACEMENT_VALUE=192.168.150.70:2181
#sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $KAFKA_CONFIG/server_1.properties
#


