#!/usr/bin/env bash

sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum -y  install java
sudo yum install jenkins

# firewall-cmd --zone=public --add-port=8080/tcp --permanent
# firewall-cmd --reload
sudo /etc/init.d/jenkins restart
#systemctl restart jenkins.service

