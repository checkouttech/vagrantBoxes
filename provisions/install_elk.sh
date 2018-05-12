
############################################
###  Install elastic search 
############################################


export ES_PACKAGE=elasticsearch-6.2.4.tar.gz

# download es 
#wget --quiet --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/$JDK_PACKAGE"

wget --quiet https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.2.4.tar.gz

export ES_HOME=/opt/elasticsearch/
sudo mkdir $ES_HOME

sudo tar -zxvf $ES_PACKAGE   --strip-components 1  -C $ES_HOME

## give permission to entire elasticsearch setup directory
sudo chown -R vagrant:vagrant $ES_HOME
sudo chmod 755 -R $ES_HOME



# needed to access elasticsearch from outside 
sudo /bin/sh -c 'echo "network.host: 0.0.0.0" >> /opt/elasticsearch/config/elasticsearch.yml'


# set file descriptors 
sudo /bin/sh -c 'echo "vagrant          -       nofile          65536" >> /etc/security/limits.conf  '
# set max map count 
sudo sysctl -w vm.max_map_count=262144




export PATH=$ES_HOME/bin:$PATH

#write to environment file for all future sessions 
sudo /bin/sh -c 'echo ES_HOME="/opt/elasticsearch/" >> /etc/environment' 
sudo /bin/sh -c '.  /etc/environment ; echo PATH="$ES_HOME/bin:$PATH" >> /etc/environment'

############################################
###  Install kibana
############################################


export KIBANA_PACKAGE=kibana-6.2.4-linux-x86_64.tar.gz

# download kibana 
wget --quiet https://artifacts.elastic.co/downloads/kibana/$KIBANA_PACKAGE

export KIBANA_HOME=/opt/kibana/
sudo mkdir $KIBANA_HOME

sudo tar -zxvf $KIBANA_PACKAGE --strip-components 1 -C $KIBANA_HOME

## give permission to entire kibana setup directory
sudo chown -R vagrant:vagrant $KIBANA_HOME
sudo chmod 755 -R $KIBANA_HOME

export PATH=$KIBANA_HOME/bin:$PATH

#write to environment file for all future sessions 
sudo /bin/sh -c 'echo KIBANA_HOME="/opt/kibana/" >> /etc/environment' 
sudo /bin/sh -c '.  /etc/environment ; echo PATH="$KIBANA_HOME/bin:$PATH" >> /etc/environment'

############################################
###  Install log stash 
############################################

export LOGSTASH_PACKAGE=logstash-6.2.4.tar.gz

# download logstash 
wget --quiet https://artifacts.elastic.co/downloads/logstash/$LOGSTASH_PACKAGE

export LOGSTASH_HOME=/opt/logstash/
sudo mkdir $LOGSTASH_HOME

sudo tar -zxvf $LOGSTASH_PACKAGE --strip-components 1 -C $LOGSTASH_HOME

## give permission to entire logstash setup directory
sudo chown -R vagrant:vagrant $LOGSTASH_HOME 
sudo chmod 755 -R $LOGSTASH_HOME

export PATH=$LOGSTASH_HOME/bin:$PATH

#write to environment file for all future sessions 
sudo /bin/sh -c 'echo LOGSTASH_HOME="/opt/logstash/" >> /etc/environment' 
sudo /bin/sh -c '.  /etc/environment ; echo PATH="$LOGSTASH_HOME/bin:$PATH" >> /etc/environment'




# Disable firewall 
sudo systemctl stop firewalld
sudo systemctl disable firewalld



sudo   echo '0.0.0.0 localhost' >> /etc/hosts
sudo /etc/init.d/network restart

## Other option ( needs yum ) 
# working version 
#sudo yum -y  install java

