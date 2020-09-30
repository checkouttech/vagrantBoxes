############################################
###  Install log stash 
############################################

export LOGSTASH_PACKAGE=logstash-7.9.2.tar.gz

# download logstash 
wget --quiet https://artifacts.elastic.co/downloads/logstash/$LOGSTASH_PACKAGE


export LOGSTASH_HOME=/opt/logstash/
sudo mkdir $LOGSTASH_HOME

sudo tar -zxvf $LOGSTASH_PACKAGE --strip-components 1 -C $LOGSTASH_HOME

## give permission to entire logstash setup directory
sudo chown -R vagrant:vagrant $LOGSTASH_HOME 
sudo chmod 755 -R $LOGSTASH_HOME

# needed to access logstash from outside 
sudo /bin/sh -c 'echo "http.host: 0.0.0.0"  >> /opt/logstash/config/logstash.yml'
# http.host: 0.0.0.0
# declare elasticsearch url 
#sudo /bin/sh -c 'echo "var.elasticsearch.hosts: http://192.168.150.150:9200/" >> /opt/logstash/config/logstash.yml'
# declare kibana url 
#sudo /bin/sh -c 'echo "var.kibana.host: http://192.168.150.150:5601/" >> /opt/logstash/config/logstash.yml'


# setup paths
export PATH=$LOGSTASH_HOME/bin:$PATH

#write to environment file for all future sessions 
sudo /bin/sh -c 'echo LOGSTASH_HOME="/opt/logstash/" >> /etc/environment' 
sudo /bin/sh -c '.  /etc/environment ; echo PATH="$LOGSTASH_HOME/bin:$PATH" >> /etc/environment'



 /opt/logstash/bin/logstash -e 'input { stdin { } } output { stdout {} }'
