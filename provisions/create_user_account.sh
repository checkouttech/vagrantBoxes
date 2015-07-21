#!/usr/bin/env bash

# to create a "prodicon" gruop with id of 700 
sudo groupadd prodicon -g 700


# to add prodicon user with prodicon passwd
sudo useradd prodicon -p  prmdFORf4MzTI  -d /home/prodicon  -s /bin/bash  -m  -g 700 -u  700
#sudo useradd prodicon -p  prmdFORf4MzTI  -d /home/prodicon -s /bin/bash  -m 
[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"

# to make prodicon as sudo user in centos
# add prodicon to sudoers file 
sudo   echo 'prodicon	ALL=(ALL:ALL)	ALL' >> /etc/sudoers

# to make prodicon as sudo user in ubuntu 
#sudo usermod -aG sudo prodicon



