#!/usr/bin/env bash

# download druid
wget --quiet  http://static.druid.io/artifacts/releases/druid-0.9.1.1-bin.tar.gz


export DRUID_HOME=/opt/druid/
export DRUID=$DRUID_HOME/bin
export DRUID_CONFIG=$DRUID_HOME/conf


#write to environment file for all future sessions
sudo /bin/sh -c 'echo export DRUID_HOME="/opt/druid/" >> /etc/environment'
sudo /bin/sh -c 'echo export DRUID="$DRUID_HOME/bin" >> /etc/environment'
sudo /bin/sh -c 'echo export DRUID_CONFIG="$DRUID_HOME/conf" >> /etc/environment'


#sudo mkdir /opt/druid
sudo mkdir $DRUID_HOME

sudo  tar -zxvf druid-0.9.1.1-bin.tar.gz  --strip-components 1  -C $DRUID_HOME

####################################################
############# config settings
####################################################

# set remote zookeeper
export TARGET_KEY=druid.zk.service.host
export REPLACEMENT_VALUE=192.168.150.70:2181
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/_common/common.runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/_common/common.runtime.properties


####################################################
######## create required directories 
####################################################

# create var directory
sudo mkdir -p $DRUID_HOME/var/
sudo chown -R vagrant:vagrant $DRUID_HOME/var/
sudo chmod 755 -R  $DRUID_HOME/var/

# create log directory
sudo mkdir -p $DRUID_HOME/log
sudo chown -R vagrant:vagrant $DRUID_HOME/log/
sudo chmod 755 -R  $DRUID_HOME/log/

# create directory created by init script 
sudo mkdir -p $DRUID_HOME/var
sudo chown -R vagrant:vagrant $DRUID_HOME/var/
sudo chmod 755 -R  $DRUID_HOME/var/


mkdir -p $DRUID_HOME/var/tmp;
mkdir -p $DRUID_HOME/var/druid/indexing-logs;
mkdir -p $DRUID_HOME/var/druid/segments;
mkdir -p $DRUID_HOME/var/druid/segment-cache;
mkdir -p $DRUID_HOME/var/druid/task;
mkdir -p $DRUID_HOME/var/druid/hadoop-tmp;
mkdir -p $DRUID_HOME/var/druid/pids;
sudo chown -R vagrant:vagrant $DRUID_HOME/var/

# create output directory
sudo mkdir -p /data/druid_output
sudo chown vagrant:vagrant /data/druid_output/
sudo chmod 755 -R /data/druid_output




####################################################
######## start druid daemon
####################################################

#$DRUID/init

####################################################################################################
####################################################################################################
####################################################################################################

# download tranquility
wget --quiet http://static.druid.io/tranquility/releases/tranquility-distribution-0.8.0.tgz

export TRANQUILITY_HOME=/opt/tranquility/
export TRANQUILITY=$TRANQUILITY_HOME/bin
export TRANQUILITY_CONFIG=$TRANQUILITY_HOME/conf


#write to environment file for all future sessions
sudo /bin/sh -c 'echo export TRANQUILITY_HOME="/opt/tranquility/" >> /etc/environment'
sudo /bin/sh -c 'echo export TRANQUILITY="$TRANQUILITY_HOME/bin" >> /etc/environment'
sudo /bin/sh -c 'echo export TRANQUILITY_CONFIG="$TRANQUILITY_HOME/conf" >> /etc/environment'


#sudo mkdir /opt/tranquility
sudo mkdir $TRANQUILITY_HOME

sudo  tar -zxvf tranquility-distribution-0.8.0.tgz  --strip-components 1  -C $TRANQUILITY_HOME

####################################################
############# config settings
####################################################

# set remote zookeeper for tranquility
export TARGET_KEY=zookeeper.connect
export REPLACEMENT_VALUE=192.168.150.70:2181
sudo sed -c -i "s/\($TARGET_KEY*\:\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/tranquility/server.json
sudo sed -c -i "s/\($TARGET_KEY*\:\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/tranquility/server.json

####################################################
############# example 
####################################################

#sudo /opt/flink/bin/flink  run  /opt/flink/examples/streaming/Kafka.jar   --topic my-topic3  --bootstrap.servers 192.168.150.80:9092   --group.id  abc   --zookeeper.connect  192.168.150.70:2181
#tail -f /opt/flink/log//flink-*-jobmanager-*.out

#  /opt/flink/bin/flink run  /opt/flink/examples/batch/WordCount.jar





####################################################
#### Restrict Java heap space to avoid overflowing limited free RAM 
#### Else not all broker will get initialized 
####################################################

#write to environment file for all future sessions 
#sudo /bin/sh -c 'echo export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M" >> /etc/environment'

#export for the current session before starting kafka cluster 
#export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"



#
## declare job manager(s) aka. master nodes 
#
#echo 'localhost:8081
#localhost:8082' > $FLINK_CONFIG/masters
#
#
#
#
## declare task managers aka.  slave nodes 
## the slaves will be on same physical box 
#
#echo 'localhost
#localhost' > $FLINK_CONFIG/slaves
#
#
## set flink-conf.yaml
#
### set log directory 
#export TARGET_KEY=taskmanager.tmp.dirs
#export REPLACEMENT_VALUE=" \\/tmp\\/flink-temp"
#
#sudo sed -c -i "s/# \($TARGET_KEY*\:*\).*/\1$REPLACEMENT_VALUE/" $FLINK_CONFIG/flink-conf.yaml 
#
#
### set tasks slots per slave/taskmanager 
#export TARGET_KEY=taskmanager.numberOfTaskSlots
#export REPLACEMENT_VALUE=" 3"
#
#sudo sed -c -i "s/\($TARGET_KEY*\:*\).*/\1$REPLACEMENT_VALUE/" $FLINK_CONFIG/flink-conf.yaml 
#
## fs.hdfs.hadoopconf
#
#
#
## set recovery mode to zookeeper
#export TARGET_KEY=recovery.mode
#export REPLACEMENT_VALUE=" zookeeper"
#sudo sed -c -i "s/# \($TARGET_KEY*\:*\).*/\1$REPLACEMENT_VALUE/" $FLINK_CONFIG/flink-conf.yaml 
#
#
## set zookeeper server info 
#export TARGET_KEY=recovery.zookeeper.quorum
#export REPLACEMENT_VALUE=" 192.168.150.70:2181"
#sudo sed -c -i "s/# \($TARGET_KEY*\:*\).*/\1$REPLACEMENT_VALUE/" $FLINK_CONFIG/flink-conf.yaml 
#
#
## set recovery storage directory 
## TODO : should be in hdfs 
#export TARGET_KEY=recovery.zookeeper.storageDir
#export REPLACEMENT_VALUE=" \\/tmp\\/"
#sudo sed -c -i "s/# \($TARGET_KEY*\:*\).*/\1$REPLACEMENT_VALUE/" $FLINK_CONFIG/flink-conf.yaml 
#
#
#
