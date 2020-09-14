## Install virtual box 
## https://www.virtualbox.org/wiki/Downloads

##
##### Clean up old vagrant setup 
##

rm -rf /Applications/Vagrant
rm -f /usr/local/bin/vagrant
sudo pkgutil --forget com.vagrant.vagrant
rm   ~/.vagrant.d/plugins.json
sudo rm -rf ~/.vagrant.d


##
##### Fresh install 
##

# First, mount the dmg image : sudo hdiutil attach <image>.dmg
# hdiutil attach https://releases.hashicorp.com/vagrant/1.8.7/vagrant_1.8.7.dmg\
# hdiutil attach https://releases.hashicorp.com/vagrant/1.9.3/vagrant_1.9.3.dmg\
hdiutil attach https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.dmg\

# The image will be mounted to /Volumes/<image>. i
# Mine contained a package which i installed with: sudo installer -package /Volumes/<image>/<image>.pkg -target /
sudo installer -package  /Volumes/Vagrant/vagrant.pkg -target /

# Finally unmount the image: sudo hdiutil detach /Volumes/<image>.
sudo hdiutil detach /Volumes/Vagrant

# check version 
# Vagrant 1.9.3 is confirmed to work 
vagrant --version


# BUG HACK for static IP issue 
sudo rm -f /opt/vagrant/embedded/bin/curl


# To install all plugins 
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-hosts
vagrant plugin install vagrant-hostsupdater
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-scp



# To reinstall all plugins 
# vagrant plugin expunge --reinstall


# To update the /etc/hosts file on each active machine, run host manager 
vagrant hostmanager

##
##### Add boxes  
##

# Box catalogue is available at http://www.vagrantbox.es/
#vagrant box add centos71 https://github.com/holms/vagrant-centos7-box/releases/download/7.1.1503.001/CentOS-7.1.1503-x86_64-netboot.box
#vagrant box add centos71 https://github.com/holms/vagrant-centos7-box/releases/download/7.1.1503.001/CentOS-7.1.1503-x86_64-netboot.box
vagrant box add centos72 https://github.com/CommanderK5/packer-centos-template/releases/download/0.7.2/vagrant-centos-7.2.box



##
##### Create box 
##


# Blank installation 
# vagrant init
# vagrant up
# vagrant ssh 

# previously declared box 
# vagrant up app-dev1.vm.local

# Login 
# vagrant ssh app-dev1.vm.local





