#!/usr/bin/env bash

# download hadoop
wget --quiet http://apache.claz.org/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz

export HADOOP_HOME=/opt/hadoop/
export HADOOP=$HADOOP_HOME/bin
export HADOOP_CONFIG=$HADOOP_HOME/etc/hadoop/
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop/


#write to environment file for all future sessions
sudo /bin/sh -c 'echo export HADOOP_HOME="/opt/hadoop/" >> /etc/environment'
sudo /bin/sh -c 'echo export HADOOP="$HADOOP_HOME/bin" >> /etc/environment'
sudo /bin/sh -c 'echo export HADOOP_CONFIG="$HADOOP_HOME/conf" >> /etc/environment'
sudo /bin/sh -c 'echo export HADOOP_CONF_DIR="$HADOOP_HOME/etc/hadoop" >> /etc/environment'



#sudo mkdir /opt/hadoop
sudo mkdir $HADOOP_HOME

sudo  tar -zxvf hadoop-2.7.2.tar.gz  --strip-components 1  -C $HADOOP_HOME


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
#sudo  -u hadoop ssh-copy-id -i  /home/hadoop/.ssh/id_rsa.pub -o StrictHostKeyChecking=no  hadoop@hadoop-master.vm.local
#sudo  -u hadoop ssh-copy-id -i  /home/hadoop/.ssh/id_rsa.pub -o StrictHostKeyChecking=no  hadoop@hadoop-slave-1.vm.local

#sudo -u hadoop chmod 0600 ~/.ssh/authorized_keys


## give permission to entire hadoop setup directory
sudo chown -R hadoop:hadoop $HADOOP_HOME
sudo chmod 755 -R $HADOOP_HOME



####################################################
############# env settings
####################################################

sudo echo '192.168.150.120  hadoop-master.vm.local
192.168.150.121  hadoop-slave-1.vm.local
192.168.150.122  hadoop-slave-2.vm.local' >> /etc/hosts



# NOTE : Very very important for master to listen on hostname:9000 channel
# to be run only on hadoop master

THISHOST=$(hostname)

if [ $THISHOST = "hadoop-master.vm.local" ]
then
   echo "will run command "
   sudo sed -c -i "s/\(127.0.1.1 .*\)/#\1/" /etc/hosts
fi




####################################################
############# config settings
####################################################

# declare master / namenode
sudo echo '
hadoop-master.vm.local
' > $HADOOP_CONF_DIR/masters


# declare slaves / datanodes
sudo echo '
hadoop-slave-1.vm.local
' > $HADOOP_CONF_DIR/slaves


# write core-site.xml

sudo echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
   <property>
      <name>fs.default.name</name>
      <value>hdfs://hadoop-master.vm.local:9000/</value>
   </property>
   <property>
      <name>dfs.permissions</name>
      <value>false</value>
   </property>
</configuration>

' > $HADOOP_CONF_DIR/core-site.xml


# write hdfs-site.xml

sudo echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->


<configuration>
   <property>
      <name>dfs.data.dir</name>
      <value>/opt/hadoop/hadoop/dfs/name/data</value>
      <final>true</final>
   </property>

   <property>
      <name>dfs.name.dir</name>
      <value>/opt/hadoop/hadoop/dfs/name</value>
      <final>true</final>
   </property>

   <property>
      <name>dfs.replication</name>
      <value>1</value>
   </property>
</configuration>

' > $HADOOP_CONF_DIR/hdfs-site.xml


# write mapred-site.xml

sudo echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
   <property>
      <name>mapred.job.tracker</name>
      <value>hadoop-master.vm.local:9001</value>
   </property>
</configuration>

' > $HADOOP_CONF_DIR/mapred-site.xml






export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true
sudo /bin/sh -c 'echo export HADOOP_OPTS="-Djava.net.preferIPv4Stack=true" >> /etc/environment'


#####################################################
######### start hadoop - Manual steps
#####################################################


## Change user to hadoop
# su - hadoop

## Master - create namenode
#/opt/hadoop/bin/hadoop namenode -format

## Start dfs service
# /opt/hadoop/sbin/start-all.sh
# /opt/hadoop/sbin/start-dfs.sh

## Check dfs
# /opt/hadoop/bin/hdfs dfs -ls /

## create tmp directory in dfs
# /opt/hadoop/bin/hadoop fs -mkdir /tmp/

## change mode
#/opt/hadoop/bin/hadoop fs -chmod 0777 /tmp

## Stop dfs service
# /opt/hadoop/sbin/stop-all.sh
# /opt/hadoop/sbin/stop-dfs.sh











####################################################################################################
####################################################################################################
####################################################################################################




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
#####################################################
######### start flink daemon
#####################################################
#
## sudo $FLINK/start-local.sh
#sudo $FLINK/start-cluster.sh
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
#
#

####################################################
#### Restrict Java heap space to avoid overflowing limited free RAM
#### Else not all broker will get initialized
####################################################

#write to environment file for all future sessions
#sudo /bin/sh -c 'echo export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M" >> /etc/environment'

#export for the current session before starting kafka cluster
#export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"


