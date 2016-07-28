#!/usr/bin/env bash


sudo yum -y install net-tools
sudo yum -y install nc
sudo yum -y install vim

sudo yum -y install rpm-build



sudo yum -y install telnet
sudo yum -y install netstat


# Disable firewall
sudo systemctl stop firewalld
sudo systemctl disable firewalld

