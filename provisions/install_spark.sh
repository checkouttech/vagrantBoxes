#!/usr/bin/env bash

# download spark
wget --quiet  https://dist.apache.org/repos/dist/release/spark/spark-2.0.0-preview/spark-2.0.0-preview-bin-hadoop2.7.tgz

export SPARK_HOME=/opt/spark/
export SPARK=$SPARK_HOME/bin
export SPARK_CONFIG=$SPARK_HOME/conf


#write to environment file for all future sessions
sudo /bin/sh -c 'echo export SPARK_HOME="/opt/spark/" >> /etc/environment'
sudo /bin/sh -c 'echo export SPARK="$SPARK_HOME/bin" >> /etc/environment'
sudo /bin/sh -c 'echo export SPARK_CONFIG="$SPARK_HOME/conf" >> /etc/environment'


#sudo mkdir /opt/spark
sudo mkdir $SPARK_HOME

sudo  tar -zxvf spark-2.0.0-preview-bin-hadoop2.7.tgz --strip-components 1  -C $SPARK_HOME

####################################################
############# user settings
####################################################

## create hadoop user
sudo useradd hadoop

## set password to hadoop
echo hadoop | sudo passwd --stdin  hadoop


## run passwordless  key-gen and save to hadoop user
sudo -u hadoop ssh-keygen -t rsa -N ""  -f /home/hadoop/.ssh/id_rsa  -q

## share public keys with remote boxes
## TODO : how to run this step without prompting for password "hadoop"
sudo  -u hadoop ssh-copy-id -i  /home/hadoop/.ssh/id_rsa.pub -o StrictHostKeyChecking=no  hadoop@spark-cluster.vm.local
sudo  -u hadoop ssh-copy-id -i  /home/hadoop/.ssh/id_rsa.pub -o StrictHostKeyChecking=no  hadoop@spark-cluster.vm.local


#sudo -u hadoop chmod 0600 ~/.ssh/authorized_keys


## give permission to entire hadoop setup directory
#sudo chown -R hadoop:hadoop $SPARK_HOME
sudo chown -R vagrant:vagrant $SPARK_HOME
sudo chmod 755 -R $SPARK_HOME



####################################################
############# env settings
####################################################

# NOTE : Very very important for master to listen on hostname:9000 channel
# to be run only on hadoop master
sudo sed -c -i "s/\(127.0.1.1 .*\)/#\1/" /etc/hosts

####################################################
############# config settings
####################################################

# declare master / namenode
### sudo echo '
###  hadoop-master.vm.local
### ' > $SPARK_CONF_DIR/masters


## declare task managers aka.  slave nodes
## the slaves will be on same physical box
# declare slaves / datanodes
echo 'spark-cluster.vm.local
' > $SPARK_CONFIG/slaves



####################################################
############# start spark cluster 
####################################################


# start master 
# sudo /opt/spark/sbin/start-master.sh

# start slave 
# sudo /opt/spark/sbin/start-slave.sh   spark://192.168.150.130:7077
 
# start all 
/opt/spark/sbin/start-all.sh

####################################################
############# example
####################################################


# Dashboard 
# http://192.168.150.130:8080/



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
#
#
#
#####################################################
######### start flink daemon
#####################################################
#
## create log directory
## give permission to logger's log directory
## TODO : see if this can be changed to a different location
#
## mkdir /opt/flink/log
#sudo chown vagrant:vagrant /opt/flink/log/
#sudo chmod -R 755 /opt/flink/log/
#
## create output directory
#sudo mkdir -p /data/flink_output
#sudo chown vagrant:vagrant /data/flink_output/
#sudo chmod 755 -R /data/flink_output
#
#
## create temp directory
#mkdir /tmp/flink-temp
#sudo chown vagrant:vagrant /tmp/flink-temp
#
#
#
#
#
#####################################################
############## example
#####################################################
#
##sudo /opt/flink/bin/flink  run  /opt/flink/examples/streaming/Kafka.jar   --topic my-topic3  --bootstrap.servers 192.168.150.80:9092   --group.id  abc   --zookeeper.connect  192.168.150.70:2181
##tail -f /opt/flink/log//flink-*-jobmanager-*.out
#
##  /opt/flink/bin/flink run  /opt/flink/examples/batch/WordCount.jar
#
#
##
##Word count ( kafka streaming )
##
##  TODO : currently not working
##   sudo /opt/flink/bin/flink  run  /opt/flink/examples/streaming/Kafka.jar   --topic my-topic3 --bootstrap.servers 192.168.150.80:9092   --group.id  abc   --zookeeper.connect  192.168.150.70:2181
#
##Word count ( batch )
##
## /opt/flink/bin/flink run  /opt/flink/examples/batch/WordCount.jar
##
## Word count ( batch on hdfs)
##
##   /opt/flink/bin/flink run  /opt/flink/examples/batch/WordCount.jar --input hdfs://192.168.150.120:9000/tmp/test-events.1468355835271
##
##   # should work when fs.hdfs.hadoopconf
##   /opt/flink/bin/flink run  /opt/flink/examples/batch/WordCount.jar --input hdfs:///tmp/test-events.1468374669125  ( currently not working , need troubleshooting )
##
##
##Word count ( submit a job )
##
##    sudo /opt/flink/bin/flink run   --submit /opt/flink/examples/streaming/Kafka.jar   --topic my-topic3  --bootstrap.servers 192.168.150.80:9092   --group.id  abc   --zookeeper.connect  192.168.150.70:2181   --jobmanager  localhost:6122
##
##Location of log files
##
## tail -f /opt/flink/log//flink-*-jobmanager-*.out
##
#####################################################
##### Restrict Java heap space to avoid overflowing limited free RAM
##### Else not all broker will get initialized
#####################################################
#
##write to environment file for all future sessions
##sudo /bin/sh -c 'echo export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M" >> /etc/environment'
#
##export for the current session before starting kafka cluster
##export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"
#

