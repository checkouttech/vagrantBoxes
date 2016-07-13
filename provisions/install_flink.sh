#!/usr/bin/env bash

# download flink
wget --quiet  http://apache.claz.org/flink/flink-1.0.3/flink-1.0.3-bin-hadoop27-scala_2.11.tgz


export FLINK_HOME=/opt/flink/
export FLINK=$FLINK_HOME/bin
export FLINK_CONFIG=$FLINK_HOME/conf


#write to environment file for all future sessions
sudo /bin/sh -c 'echo export FLINK_HOME="/opt/flink/" >> /etc/environment'
sudo /bin/sh -c 'echo export FLINK="$FLINK_HOME/bin" >> /etc/environment'
sudo /bin/sh -c 'echo export FLINK_CONFIG="$FLINK_HOME/conf" >> /etc/environment'


#sudo mkdir /opt/flink
sudo mkdir $FLINK_HOME

sudo  tar -zxvf flink-1.0.3-bin-hadoop27-scala_2.11.tgz  --strip-components 1  -C $FLINK_HOME

####################################################
############# config settings
####################################################


# declare job manager(s) aka. master nodes

echo 'localhost:8081
localhost:8082' > $FLINK_CONFIG/masters




# declare task managers aka.  slave nodes
# the slaves will be on same physical box

echo 'localhost
localhost' > $FLINK_CONFIG/slaves


# set flink-conf.yaml

## set log directory
export TARGET_KEY=taskmanager.tmp.dirs
export REPLACEMENT_VALUE=" \\/tmp\\/flink-temp"

sudo sed -c -i "s/# \($TARGET_KEY*\:*\).*/\1$REPLACEMENT_VALUE/" $FLINK_CONFIG/flink-conf.yaml


## set tasks slots per slave/taskmanager
export TARGET_KEY=taskmanager.numberOfTaskSlots
export REPLACEMENT_VALUE=" 3"

sudo sed -c -i "s/\($TARGET_KEY*\:*\).*/\1$REPLACEMENT_VALUE/" $FLINK_CONFIG/flink-conf.yaml

# fs.hdfs.hadoopconf



# set recovery mode to zookeeper
export TARGET_KEY=recovery.mode
export REPLACEMENT_VALUE=" zookeeper"
sudo sed -c -i "s/# \($TARGET_KEY*\:*\).*/\1$REPLACEMENT_VALUE/" $FLINK_CONFIG/flink-conf.yaml


# set zookeeper server info
export TARGET_KEY=recovery.zookeeper.quorum
export REPLACEMENT_VALUE=" 192.168.150.70:2181"
sudo sed -c -i "s/# \($TARGET_KEY*\:*\).*/\1$REPLACEMENT_VALUE/" $FLINK_CONFIG/flink-conf.yaml


# set recovery storage directory
# TODO : should be in hdfs
export TARGET_KEY=recovery.zookeeper.storageDir
export REPLACEMENT_VALUE=" \\/tmp\\/"
sudo sed -c -i "s/# \($TARGET_KEY*\:*\).*/\1$REPLACEMENT_VALUE/" $FLINK_CONFIG/flink-conf.yaml






####################################################
######## start flink daemon
####################################################

# create log directory
# give permission to logger's log directory
# TODO : see if this can be changed to a different location

# mkdir /opt/flink/log
sudo chown vagrant:vagrant /opt/flink/log/
sudo chmod -R 755 /opt/flink/log/

# create output directory
sudo mkdir -p /data/flink_output
sudo chown vagrant:vagrant /data/flink_output/
sudo chmod 755 -R /data/flink_output


# create temp directory
mkdir /tmp/flink-temp
sudo chown vagrant:vagrant /tmp/flink-temp




####################################################
######## start flink daemon
####################################################

# start / stop cluster
# sudo $FLINK/start-cluster.sh
$FLINK/start-cluster.sh

# start / stop LOCAL
# sudo $FLINK/start-local.sh
# sudo /opt/flink/bin/stop-local.sh
#
####################################################
############# example
####################################################

#sudo /opt/flink/bin/flink  run  /opt/flink/examples/streaming/Kafka.jar   --topic my-topic3  --bootstrap.servers 192.168.150.80:9092   --group.id  abc   --zookeeper.connect  192.168.150.70:2181
#tail -f /opt/flink/log//flink-*-jobmanager-*.out

#  /opt/flink/bin/flink run  /opt/flink/examples/batch/WordCount.jar


#
#Word count ( kafka streaming )
#
#  TODO
#
#Word count ( batch )
#
# /opt/flink/bin/flink run  /opt/flink/examples/batch/WordCount.jar
#
# Word count ( batch on hdfs)
#
#   /opt/flink/bin/flink run  /opt/flink/examples/batch/WordCount.jar --input hdfs://192.168.150.120:9000/tmp/test-events.1468355835271
#
#   # should work when fs.hdfs.hadoopconf
#   /opt/flink/bin/flink run  /opt/flink/examples/batch/WordCount.jar --input hdfs:///tmp/test-events.1468374669125  ( currently not working , need troubleshooting )
#
#
#Word count ( submit a job )
#
#
#Location of log files
#
# tail -f /opt/flink/log//flink-*-jobmanager-*.out
#
####################################################
#### Restrict Java heap space to avoid overflowing limited free RAM
#### Else not all broker will get initialized
####################################################

#write to environment file for all future sessions
#sudo /bin/sh -c 'echo export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M" >> /etc/environment'

#export for the current session before starting kafka cluster
#export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"


