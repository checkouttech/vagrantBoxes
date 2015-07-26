#!/usr/bin/env bash

# To deploy node js 
wget https://nodejs.org/dist/v0.12.7/node-v0.12.7-linux-x64.tar.gz .
sudo tar --strip-components 1 -xzvf node-v0.12.7-linux-x64.tar.gz  -C /usr/local/

#wget http://nodejs.org/dist/v0.10.25/node-v0.10.25.tar.gz
#
#tar -zxf node-v0.10.25.tar.gz  
#cd node-v0.10.25  
#./configure
#make  
#sudo make install  

