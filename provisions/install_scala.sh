#!/usr/bin/env bash

# download scala
wget --quiet  http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz

export SCALA_HOME=/opt/scala/
export SCALA=$SCALA_HOME/bin
export SCALA_CONFIG=$SCALA_HOME/conf
export PATH=$PATH:$SCALA

#write to environment file for all future sessions
sudo /bin/sh -c 'echo export SCALA_HOME="/opt/scala/" >> /etc/environment'
sudo /bin/sh -c 'echo export SCALA="$SCALA_HOME/bin" >> /etc/environment'
sudo /bin/sh -c 'echo export SCALA_CONF="$SCALA_HOME/conf" >> /etc/environment'
sudo /bin/sh -c 'echo export PATH="$PATH:$SCALA" >> /etc/environment'

#sudo mkdir /opt/scala
sudo mkdir $SCALA_HOME

sudo  tar -zxvf scala-2.11.8.tgz  --strip-components 1  -C $SCALA_HOME




# download sbt
wget --quiet  https://dl.bintray.com/sbt/native-packages/sbt/0.13.11/sbt-0.13.11.tgz 

export SBT_HOME=/opt/sbt/
export SBT=$SBT_HOME/bin
export SBT_CONFIG=$SBT_HOME/conf
export PATH=$PATH:$SBT

#write to environment file for all future sessions
sudo /bin/sh -c 'echo export SBT_HOME="/opt/sbt/" >> /etc/environment'
sudo /bin/sh -c 'echo export SBT="$SBT_HOME/bin" >> /etc/environment'
sudo /bin/sh -c 'echo export SBT_CONF="$SBT_HOME/conf" >> /etc/environment'
sudo /bin/sh -c 'echo export PATH="$PATH:$SBT" >> /etc/environment'

#sudo mkdir /opt/sbt
sudo mkdir $SBT_HOME

# sudo unzip   sbt-0.13.9.zip  -d /opt/
sudo  tar -zxvf sbt-0.13.11.tgz  --strip-components 1  -C $SBT_HOME



