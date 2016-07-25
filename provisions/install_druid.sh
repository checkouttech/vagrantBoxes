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


# set deep storage
export TARGET_KEY=druid.extensions.loadList
export REPLACEMENT_VALUE='["druid-hdfs-storage"]'
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/_common/common.runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/_common/common.runtime.properties

export LINE_TO_UNCOMMENT=druid.storage.type=hdfs
sudo sed -c -i "s/#\($LINE_TO_UNCOMMENT\).*/\1/"   $DRUID_CONFIG/druid/_common/common.runtime.properties
sudo sed -c -i "s/#\($LINE_TO_UNCOMMENT\).*/\1/"   $DRUID_CONFIG/../conf-quickstart/druid/_common/common.runtime.properties

export LINE_TO_UNCOMMENT='druid.storage.storageDirectory=\/druid\/segments'
sudo sed -c -i "s/#\($LINE_TO_UNCOMMENT\).*/\1/"   $DRUID_CONFIG/druid/_common/common.runtime.properties
sudo sed -c -i "s/#\($LINE_TO_UNCOMMENT\).*/\1/"   $DRUID_CONFIG/../conf-quickstart/druid/_common/common.runtime.properties

export LINE_TO_UNCOMMENT=druid.indexer.logs.type=hdfs
sudo sed -c -i "s/#\($LINE_TO_UNCOMMENT\).*/\1/"   $DRUID_CONFIG/druid/_common/common.runtime.properties
sudo sed -c -i "s/#\($LINE_TO_UNCOMMENT\).*/\1/"   $DRUID_CONFIG/../conf-quickstart/druid/_common/common.runtime.properties


export LINE_TO_UNCOMMENT='druid.indexer.logs.directory=\/druid\/indexing-logs'
sudo sed -c -i "s/#\($LINE_TO_UNCOMMENT\).*/\1/"   $DRUID_CONFIG/druid/_common/common.runtime.properties
sudo sed -c -i "s/#\($LINE_TO_UNCOMMENT\).*/\1/"   $DRUID_CONFIG/../conf-quickstart/druid/_common/common.runtime.properties


# #########################

export LINE_TO_COMMENT=druid.storage.type=local
sudo sed -c -i "s/\($LINE_TO_COMMENT\).*/#\1/"   $DRUID_CONFIG/druid/_common/common.runtime.properties
sudo sed -c -i "s/\($LINE_TO_COMMENT\).*/#\1/"   $DRUID_CONFIG/../conf-quickstart/druid/_common/common.runtime.properties

export LINE_TO_COMMENT='druid.storage.storageDirectory=var\/druid\/segments'
sudo sed -c -i "s/\($LINE_TO_COMMENT\).*/#\1/"   $DRUID_CONFIG/druid/_common/common.runtime.properties
sudo sed -c -i "s/\($LINE_TO_COMMENT\).*/#\1/"   $DRUID_CONFIG/../conf-quickstart/druid/_common/common.runtime.properties

export LINE_TO_COMMENT=druid.indexer.logs.type=file
sudo sed -c -i "s/\($LINE_TO_COMMENT\).*/#\1/"   $DRUID_CONFIG/druid/_common/common.runtime.properties
sudo sed -c -i "s/\($LINE_TO_COMMENT\).*/#\1/"   $DRUID_CONFIG/../conf-quickstart/druid/_common/common.runtime.properties

export LINE_TO_COMMENT='druid.indexer.logs.directory=var\/druid\/indexing-logs'
sudo sed -c -i "s/\($LINE_TO_COMMENT\).*/#\1/"   $DRUID_CONFIG/druid/_common/common.runtime.properties
sudo sed -c -i "s/\($LINE_TO_COMMENT\).*/#\1/"   $DRUID_CONFIG/../conf-quickstart/druid/_common/common.runtime.properties


##########
### borker properties
##########

sudo sed -c -i "s/-Xms.*/-Xms1g/"  $DRUID_CONFIG/druid/broker/jvm.config
sudo sed -c -i "s/-Xms.*/-Xms1g/"  $DRUID_CONFIG/../conf-quickstart/druid/broker/jvm.config

sudo sed -c -i "s/-Xmx.*/-Xmx1g/"  $DRUID_CONFIG/druid/broker/jvm.config
sudo sed -c -i "s/-Xmx.*/-Xmx1g/"  $DRUID_CONFIG/../conf-quickstart/druid/broker/jvm.config

sudo sed -c -i "s/-XX:MaxDirectMemorySize.*/-XX:MaxDirectMemorySize=1280m/"  $DRUID_CONFIG/druid/broker/jvm.config
sudo sed -c -i "s/-XX:MaxDirectMemorySize.*/-XX:MaxDirectMemorySize=1280m/"  $DRUID_CONFIG/../conf-quickstart/druid/broker/jvm.config



export TARGET_KEY=druid.server.http.numThreads
export REPLACEMENT_VALUE=8
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/broker/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/broker/runtime.properties


export TARGET_KEY=druid.processing.buffer.sizeBytes
export REPLACEMENT_VALUE=256000000
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/broker/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/broker/runtime.properties


export TARGET_KEY=druid.processing.numThreads
export REPLACEMENT_VALUE=2
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/broker/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/broker/runtime.properties


export TARGET_KEY=druid.cache.sizeInBytes
export REPLACEMENT_VALUE=10000000
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/broker/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/broker/runtime.properties



##########
### coordinator properties
##########

sudo sed -c -i "s/-Xms.*/-Xms256m/"  $DRUID_CONFIG/druid/coordinator/jvm.config
sudo sed -c -i "s/-Xms.*/-Xms256m/"  $DRUID_CONFIG/../conf-quickstart/druid/coordinator/jvm.config

sudo sed -c -i "s/-Xmx.*/-Xmx256m/"  $DRUID_CONFIG/druid/coordinator/jvm.config
sudo sed -c -i "s/-Xmx.*/-Xmx256m/"  $DRUID_CONFIG/../conf-quickstart/druid/coordinator/jvm.config


export TARGET_KEY=druid.coordinator.startDelay
export REPLACEMENT_VALUE=PT10S
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/coordinator/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/coordinator/runtime.properties


export TARGET_KEY=druid.coordinator.period
export REPLACEMENT_VALUE=PT5S
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/coordinator/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/coordinator/runtime.properties



##########
### historical properties
##########

sudo sed -c -i "s/-Xms.*/-Xms1g/"  $DRUID_CONFIG/druid/historical/jvm.config
sudo sed -c -i "s/-Xms.*/-Xms1g/"  $DRUID_CONFIG/../conf-quickstart/druid/historical/jvm.config

sudo sed -c -i "s/-Xmx.*/-Xmx1g/"  $DRUID_CONFIG/druid/historical/jvm.config
sudo sed -c -i "s/-Xmx.*/-Xmx1g/"  $DRUID_CONFIG/../conf-quickstart/druid/historical/jvm.config

sudo sed -c -i "s/-XX:MaxDirectMemorySize.*/-XX:MaxDirectMemorySize=1280m/"  $DRUID_CONFIG/druid/historical/jvm.config
sudo sed -c -i "s/-XX:MaxDirectMemorySize.*/-XX:MaxDirectMemorySize=1280m/"  $DRUID_CONFIG/../conf-quickstart/druid/historical/jvm.config





export TARGET_KEY=druid.server.http.numThreads
export REPLACEMENT_VALUE=8
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/historical/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/historical/runtime.properties


export TARGET_KEY=druid.processing.buffer.sizeBytes
export REPLACEMENT_VALUE=256000000
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/historical/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/historical/runtime.properties


export TARGET_KEY=druid.processing.numThreads
export REPLACEMENT_VALUE=2
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/historical/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/historical/runtime.properties


# TODO druid.segmentCache.locations
export TARGET_KEY=druid.segmentCache.locations
export REPLACEMENT_VALUE='[{"path":"var\/druid\/segment-cache","maxSize"\\:300000000000}]'
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/historical/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/historical/runtime.properties


export TARGET_KEY=druid.server.maxSize
export REPLACEMENT_VALUE=300000000000
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/historical/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/historical/runtime.properties



##########
### middle manager
##########

export TARGET_KEY=druid.server.http.numThreads
export REPLACEMENT_VALUE=8
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/middleManager/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/middleManager/runtime.properties


export TARGET_KEY=druid.processing.buffer.sizeBytes
export REPLACEMENT_VALUE=256000000
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/middleManager/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/middleManager/runtime.properties


export TARGET_KEY=druid.indexer.task.hadoopWorkingPath
export REPLACEMENT_VALUE='\/tmp\/druid-indexing'
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/middleManager/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/middleManager/runtime.properties



##########
### overlord properties
##########


sudo sed -c -i "s/-Xms.*/-Xms256m/"  $DRUID_CONFIG/druid/overlord/jvm.config
sudo sed -c -i "s/-Xms.*/-Xms256m/"  $DRUID_CONFIG/../conf-quickstart/druid/overlord/jvm.config

sudo sed -c -i "s/-Xmx.*/-Xmx256m/"  $DRUID_CONFIG/druid/overlord/jvm.config
sudo sed -c -i "s/-Xmx.*/-Xmx256m/"  $DRUID_CONFIG/../conf-quickstart/druid/overlord/jvm.config

export TARGET_KEY=druid.indexer.queue.startDelay
export REPLACEMENT_VALUE=PT5S
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/druid/overlord/runtime.properties
sudo sed -c -i "s/\($TARGET_KEY=\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/druid/overlord/runtime.properties


####################################################
############# tranquility  settings
####################################################

# set remote zookeeper for tranquility
export TARGET_KEY=zookeeper.connect
export REPLACEMENT_VALUE=192.168.150.70:2181
sudo sed -c -i "s/\($TARGET_KEY*\:\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/tranquility/server.json
sudo sed -c -i "s/\($TARGET_KEY*\:\).*/\1$REPLACEMENT_VALUE/"   $DRUID_CONFIG/../conf-quickstart/tranquility/server.json

# TODO : setup kafka zookeeper.connect
# TODO :  setup zookeeper.connect




##########
### HDFS properties
##########


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

' > $DRUID_CONFIG/druid/_common/core-site.xml

sudo cp $DRUID_CONFIG/druid/_common/core-site.xml  $DRUID_CONFIG/../conf-quickstart/druid/_common/


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

' > $DRUID_CONFIG/druid/_common/hdfs-site.xml

sudo cp $DRUID_CONFIG/druid/_common/hdfs-site.xml  $DRUID_CONFIG/../conf-quickstart/druid/_common/



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

' > $DRUID_CONFIG/druid/_common/mapred-site.xml

sudo cp $DRUID_CONFIG/druid/_common/mapred-site.xml  $DRUID_CONFIG/../conf-quickstart/druid/_common/







# sudo sed -c -i "s/# \($TARGET_KEY*\:*\).*/\1$REPLACEMENT_VALUE/" $FLINK_CONFIG/flink-conf.yaml

#druid.storage.type=local
#druid.storage.storageDirectory=var/druid/segments

#druid.storage.type=hdfs
#druid.storage.storageDirectory=/druid/segments

#druid.indexer.logs.type=file
#druid.indexer.logs.directory=var/druid/indexing-logs


#druid.indexer.logs.type=hdfs
#druid.indexer.logs.directory=/druid/indexing-logs









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
############# example
####################################################


####################################################
#### Restrict Java heap space to avoid overflowing limited free RAM
#### Else not all broker will get initialized
####################################################


