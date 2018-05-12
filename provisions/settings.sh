############################################
###  Install log stash 
############################################

# Disable firewall 
sudo systemctl stop firewalld
sudo systemctl disable firewalld

sudo   echo '0.0.0.0 localhost' >> /etc/hosts
sudo /etc/init.d/network restart


