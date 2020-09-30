############################################
###  Install elastic search 
############################################

#export ES_PACKAGE=elasticsearch-6.2.4.tar.gz
export ES_PACKAGE=elasticsearch-7.9.2-linux-x86_64.tar.gz

# download es 
wget --quiet https://artifacts.elastic.co/downloads/elasticsearch/$ES_PACKAGE

export ES_HOME=/opt/elasticsearch/
sudo mkdir $ES_HOME

sudo tar -zxvf $ES_PACKAGE   --strip-components 1  -C $ES_HOME

## give permission to entire elasticsearch setup directory
sudo chown -R vagrant:vagrant $ES_HOME
sudo chmod 755 -R $ES_HOME

# needed to access elasticsearch from outside 
sudo /bin/sh -c 'echo "network.host: 0.0.0.0" >> /opt/elasticsearch/config/elasticsearch.yml'

# setup port
sudo /bin/sh -c 'echo "http.port: 9200" >> /opt/elasticsearch/config/elasticsearch.yml'

# To avoid bootstrap checks 
sudo /bin/sh -c 'echo "discovery.type: single-node"  >> /opt/elasticsearch/config/elasticsearch.yml'


# http.host: 0.0.0.0
# path.repo: ["/tmp/backup"]


# set file descriptors 
sudo /bin/sh -c 'echo "vagrant          -       nofile          65536" >> /etc/security/limits.conf  '
# set max map count 
# To set this value permanently, update the vm.max_map_count setting in /etc/sysctl.conf. 
# To verify after rebooting  grep vm.max_map_count /etc/sysctl.conf
sudo sysctl -w vm.max_map_count=262144

# setup paths
export PATH=$ES_HOME/bin:$PATH

#write to environment file for all future sessions 
sudo /bin/sh -c 'echo ES_HOME="/opt/elasticsearch/" >> /etc/environment' 
sudo /bin/sh -c '.  /etc/environment ; echo PATH="$ES_HOME/bin:$PATH" >> /etc/environment'


