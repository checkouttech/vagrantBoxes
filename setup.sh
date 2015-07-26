

# add box 
# Box catalogue is available at http://www.vagrantbox.es/
vagrant box add centos7 https://github.com/holms/vagrant-centos7-box/releases/download/7.1.1503.001/CentOS-7.1.1503-x86_64-netboot.box


# To update the /etc/hosts file on each active machine, run the following command
vagrant plugin install vagrant-hostmanager
vagrant hostmanager

vagrant plugin install vagrant-hosts
vagrant plugin install vagrant-hostsupdater

vagrant plugin install vagrant-vbguest

# initialize vagrant 
#vagrant init

# start vagrant 
vagrant up



