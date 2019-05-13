############################################
###  Install kibana
############################################

#export KIBANA_PACKAGE=kibana-6.2.4-linux-x86_64.tar.gz
export KIBANA_PACKAGE=kibana-7.0.1-linux-x86_64.tar.gz

# download kibana 
wget --quiet https://artifacts.elastic.co/downloads/kibana/$KIBANA_PACKAGE

export KIBANA_HOME=/opt/kibana/
sudo mkdir $KIBANA_HOME

sudo tar -zxvf $KIBANA_PACKAGE --strip-components 1 -C $KIBANA_HOME

## give permission to entire kibana setup directory
sudo chown -R vagrant:vagrant $KIBANA_HOME
sudo chmod 755 -R $KIBANA_HOME

# needed to access kibana from outside 
sudo /bin/sh -c 'echo "server.host: 0.0.0.0" >> /opt/kibana/config/kibana.yml'

# declare elasticsearch url 
sudo /bin/sh -c 'echo "elasticsearch.url: http://192.168.150.150:9200" >> /opt/kibana/config/kibana.yml'
# not sure , may need to delete
sudo /bin/sh -c 'echo "elasticsearch.hosts: [\"http://localhost:9200\"] >> /opt/kibana/config/kibana.yml'

# set max zoom level
sudo /bin/sh -c 'echo "map.tilemap.options.maxZoom: 18" >> /opt/kibana/config/kibana.yml'



#tilemap.url: "https://stamen-tiles.a.ssl.fastly.net/terrain/{z}/{x}/{y}.jpg"
# tilemap.options.maxZoom: 20
# tilemap.options.attribution: 'Aerial imagery'




# setup paths
export PATH=$KIBANA_HOME/bin:$PATH

#write to environment file for all future sessions 
sudo /bin/sh -c 'echo KIBANA_HOME="/opt/kibana/" >> /etc/environment' 
sudo /bin/sh -c '.  /etc/environment ; echo PATH="$KIBANA_HOME/bin:$PATH" >> /etc/environment'


