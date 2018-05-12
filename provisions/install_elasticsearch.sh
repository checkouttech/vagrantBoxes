############################################
###  Install elastic search 
############################################

export ES_PACKAGE=elasticsearch-6.2.4.tar.gz

# download es 
wget --quiet https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.2.4.tar.gz
#wget --quiet --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/$JDK_PACKAGE"

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

# setup paths
export PATH=$ES_HOME/bin:$PATH

#write to environment file for all future sessions 
sudo /bin/sh -c 'echo ES_HOME="/opt/elasticsearch/" >> /etc/environment' 
sudo /bin/sh -c '.  /etc/environment ; echo PATH="$ES_HOME/bin:$PATH" >> /etc/environment'


