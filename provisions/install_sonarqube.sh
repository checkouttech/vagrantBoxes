#!/usr/bin/env bash

#sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
#sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

sudo yum -y  install java

# download and install sonar 
sudo wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo
sudo yum -y  install sonar

# location : /opt/sonar/

# firewall-cmd --zone=public --add-port=8080/tcp --permanent
# firewall-cmd --reload
#sudo /etc/init.d/jenkins restart
#systemctl restart jenkins.service


# Disable firewall 
sudo systemctl stop firewalld

# installing python plugin manually 
wget http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/python/sonar-python-plugin/1.5/sonar-python-plugin-1.5.jar 
sudo cp sonar-python-plugin-1.5.jar    /opt/sonar/extensions/plugins/

# start sonar 
sudo  /etc/init.d/sonar start







