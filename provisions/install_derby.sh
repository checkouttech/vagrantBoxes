#!/usr/bin/env bash

# download derby
wget --quiet  http://apache.mirrors.lucidnetworks.net//db/derby/db-derby-10.12.1.1/db-derby-10.12.1.1-bin.tar.gz


export DERBY_HOME=/opt/derby/
export DERBY=$DERBY_HOME/bin
export DERBY_CONFIG=$DERBY_HOME/conf


#write to environment file for all future sessions
sudo /bin/sh -c 'echo export DERBY_HOME="/opt/derby/" >> /etc/environment'
sudo /bin/sh -c 'echo export DERBY="$DERBY_HOME/bin" >> /etc/environment'
sudo /bin/sh -c 'echo export DERBY_CONFIG="$DERBY_HOME/conf" >> /etc/environment'


#sudo mkdir /opt/derby
sudo mkdir $DERBY_HOME

sudo  tar -zxvf db-derby-10.12.1.1-bin.tar.gz --strip-components 1  -C $DERBY_HOME


####################################################
############# config settings
####################################################



#####################################################
######### start derby daemon
#####################################################

# give hostname else it will bind itself to 0.0.0.0 
nohup java -jar $DERBY_HOME/lib/derbyrun.jar server start  -h 192.168.150.118  &


