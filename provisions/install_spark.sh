#!/usr/bin/env bash

# download spark
# wget --quiet  https://dist.apache.org/repos/dist/release/spark/spark-2.0.0-preview/spark-2.0.0-preview-bin-hadoop2.7.tgz
wget --quiet  https://dist.apache.org/repos/dist/release/spark/spark-2.1.0/spark-2.1.0-bin-hadoop2.7.tgz
wget --quiet  https://archive.apache.org/dist/spark/spark-2.1.0/spark-2.1.0-bin-hadoop2.7.tgz

export SPARK_HOME=/opt/spark/
export SPARK=$SPARK_HOME/bin
export SPARK_CONFIG=$SPARK_HOME/conf


#write to environment file for all future sessions
sudo /bin/sh -c 'echo SPARK_HOME="/opt/spark/" >> /etc/environment'
sudo /bin/sh -c 'echo SPARK="$SPARK_HOME/bin" >> /etc/environment'
sudo /bin/sh -c 'echo SPARK_CONFIG="$SPARK_HOME/conf" >> /etc/environment'


#sudo mkdir /opt/spark
sudo mkdir $SPARK_HOME

#sudo  tar -zxvf spark-2.0.0-preview-bin-hadoop2.7.tgz --strip-components 1  -C $SPARK_HOME
sudo  tar -zxvf spark-2.1.0-bin-hadoop2.7.tgz  --strip-components 1  -C $SPARK_HOME

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
sudo sed -c -i "s/\(127.0.0.1 .*\)/#\1/" /etc/hosts

####################################################
############# config settings
####################################################

# declare master / namenode
### sudo echo '
###  hadoop-master.vm.local
### ' > $SPARK_CONFIG/masters


## declare task managers aka.  slave nodes
## the slaves will be on same physical box
# declare slaves / datanodes
echo 'spark-cluster.vm.local
' > $SPARK_CONFIG/slaves


# Integrate zookeeper
echo '
export SPARK_DAEMON_JAVA_OPTS="-Dspark.deploy.recoveryMode=ZOOKEEPER -Dspark.deploy.zookeeper.url=192.168.150.70:2181"
'>> $SPARK_CONFIG/spark-env.sh

# SPARK_WORKER_INSTANCES

# /opt/spark/conf/spark-env.sh



#export SPARK_WORKER_MEMORY=1g
#export SPARK_EXECUTOR_MEMORY=512m
#export SPARK_WORKER_INSTANCES=2
#export SPARK_WORKER_CORES=2
#export SPARK_WORKER_DIR=/home/knoldus/work/sparkdata


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




