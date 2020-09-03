








Install virtual box 


http://download.virtualbox.org/virtualbox/5.0.0/VirtualBox-5.0-5.0.0_101573_el6-1.x86_64.rpm

rpm install vagrant 


yum install SDL SDL_image 



 sudo rpm -ivh VirtualBox-5.0-5.0.0_101573_el6-1.x86_64.rpm





TODO 


	+  ssh from host  ( no vagrant ssh ) 

		ADD ENTRIES TO /ETC/HOSTS   (  automate this  ) 


	+  Readme  ( consolidate notes )

	+ set up script 

	+  github packging 




SETUP 

	+	fakebidder on one box 
	+	graphite
	+	aerospike / memcache 
	+	jenkins  ( master slave config )
	+	buildbox



Commands : 

	vagrant box list
	vagrant destroy
	vagrant global-status
	vagrant global-status --prune 
	
	Reload provision 
		vagrant reload --provision

	vagrant status
	
	Listing Installed Boxes
		$ vagrant box list

	To destroy 
		vangarnt destroy


vagrant --version

vagrant plugin list







vagrant package --vagrantfile Vagrantfile.pkg
vagrant package --vagrantfile Vagrantfile.pkg  web






Setup -- 


No vagrant init on an existing setup
        vagrant init [box-name] [box-url]


 Your First Vagrant Virtual Environment

$ vagrant box add lucid32 http://files.vagrantup.com/lucid32.box
$ vagrant init lucid32
$ vagrant up

vagrant box add USER/BOX



Plugins -----



To update the /etc/hosts file on each active machine, run the following command:  
	vagrant plugin install vagrant-hostmanager
 	vagrant hostmanager

To install vagrant-hosts plugin
	vagrant plugin install vagrant-hosts


To install vbguest 
 	vagrant plugin install vagrant-vbguest
 	sudo ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions

To updated /etc/hosts
	vagrant plugin install vagrant-hostsupdater




Setup Validation 

	From terminal -  	
						curl dev1.vm.local:50000
						curl 192.168.150.101:50000
						ssh dev1.vm.local
						ssh 192.168.150.101
						ssh vagrant@192.168.150.101
						ssh vagrant@dev1.vm.local


	From browswer -   	http://dev1.vm.local/

	From VM -
						ssh dev1.vm.local
						ssh dev2.vm.local


Hard Kill all boxes 
	killall -9 VBoxHeadless && vagrant destroy

Status 
	vagrant global-status


To create an encrypted password for creating user 

	perl -e 'print crypt("prodicon", "password"),"\n"'

	# it should be first and not second
    # crypt EXPR,SALT






# synced folder

    # to share synced folder as another user
#    db.vm.synced_folder "./synced_folders/dbbox", "/home/prodicon/synced_folder",
#       owner: "prodicon",
#       group: "www-data",
#       mount_options:  ['dmode=777','fmode=777']



Generate keys 
	#   ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa


		ssh-keygen
		ssh-copy-id -i ~/.ssh/id_rsa.pub   prodicon@192.168.50.11
		ssh prodicon@192.168.50.11
		ssh-share 
		

Packaging 

	To package a new vm from an existing box 

	        vagrant package --output <target-box-name>.box  [EXISITNG BOX NAME]

	        vagrant package --output box_name.box --base "vm machine name" --vagrantfile Vagrantfile	 --include README.txt


	        --base NAME) is the name in VirtualBox


	To spin up new box from the above created vm 
	
			Take the created artificat (mynew.box ) to new location

	        vagrant box add mynewbox   /Users/kmahant/workspace/vagrant_getting_started/mynew.box











la-mac-kmahant:vagrant_getting_started kmahant$ ls ssh_keys/
id_dsa       id_dsa.pub   known_hosts




prodicon@webbox:~$ ls -lart .ssh/
total 12
drwxr-xr-x 1 prodicon vagrant 238 Jun 23 15:58 ..
-rw-r--r-- 1 prodicon vagrant 222 Jun 23 15:58 known_hosts
-rw-r--r-- 1 prodicon vagrant 605 Jun 23 18:28 id_dsa.pub
-rw------- 1 prodicon vagrant 668 Jun 23 18:28 id_dsa
drwxr-xr-x 1 prodicon vagrant 170 Jun 23 18:28 .




config.vm.provision :file do |file|
  file.source = "/etc/file1.txt"
  file.destination = "/tmp/1.txt"
end


Box 1 

	[prodicon@webbox ~]$ ls -l .ssh/
	total 12
	-rw-------. 1 prodicon prodicon 1675 Jul  9 23:07 id_rsa
	-rw-r--r--. 1 prodicon prodicon  397 Jul  9 23:07 id_rsa.pub
	-rw-r--r--. 1 prodicon prodicon  175 Jul  9 23:09 known_hosts


Box 2 

	[prodicon@dbbox ~]$ ls -l .ssh/
	total 4
	-rw-------. 1 prodicon prodicon 397 Jul  9 23:11 authorized_keys







config.ssh.forward_agent = true

into your Vagrantfile and then add the Key to the ssh agent on your host machine:
$ ssh-add ~/.ssh/id_rsa




apache installation 
	sudo yum install httpd
	sudo service httpd start




To disable firewall <<<<<<<<<<<<<<<<<<<<<<<<<<< for apache 

    sudo systemctl stop firewalld


To install 
sudo yum install httpd

ip addr

service --status-all

curl localhost:80
sudo python -m SimpleHTTPServer 80
curl -v 'http://localhost:8081/'
curl -v 'http://localhost:81/'

sudo systemctl start httpd.service
sudo python -m SimpleHTTPServer 81
sudo tail -f   /etc/httpd/logs/access_log



sudo service iptables stop
sudo chkconfig iptables off


sudo service iptables stop
sudo service iptables status
sudo service iptables stop
vim cookbooks/apache2/templates/default/iptables.erb
systemctl stop firewalld
sudo systemctl stop firewalld

Todo - 

##config.vm.network "private_network", type: "dhcp"



