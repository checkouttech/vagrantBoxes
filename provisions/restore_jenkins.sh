git clone https://github.com/kapilmahant/jenkinsConfigSync


# copy jobs 
sudo cp -r jenkinsConfigSync/jobs/*    /var/lib/jenkins/jobs/

# fetch and install plugins 
sudo wget -P /var/lib/jenkins/plugins/  -i   jenkinsConfigSync/list_of_plugins_repo 

# copy jenkins config xmls
sudo cp jenkinsConfigSync/configure/*   /var/lib/jenkins/

# change permissions 
sudo chown -R jenkins:jenkins  /var/lib/jenkins/

# restart jenkins 
sudo service jenkins restart
