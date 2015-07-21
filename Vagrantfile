# -*- mode: ruby -*-
# vi: set ft=ruby :


# Require YAML module
require 'yaml'
  
# Read YAML file with box details
servers = YAML.load_file('conf/servers.yaml')
#servers = YAML.load_file('conf/yaml_file.yaml')

# Create boxes
Vagrant.configure(2) do |config|
  
    # to disable auto update 
    config.vbguest.auto_update = false
  
    # Iterate through entries in YAML file
    servers.each do |servers|
  
        config.vm.define servers["name"] do |config|
    
          # To updagte /etc/hosts of each box 
          config.hostmanager.enabled = true
          config.hostmanager.manage_host = true
          config.hostmanager.ignore_private_ip = false
          config.hostmanager.include_offline = true
          config.vm.provision :hosts
          
          # To set box name  
          config.vm.box = servers["box"]
    
          # The hostname to SSH into
          config.vm.hostname = servers["name"]
  
          # The IP to SSH into
          config.vm.network :private_network, ip: servers["ip"]
  
          # To set resevered memory 
          #config.vm.memory = servers["mem"]
    
          # To disable vagrant from overwriting/inserting "prodicion" user's pre-existing keys  
          config.ssh.insert_key = false
    
          # with disabled true to avoid creating default folder 
          config.vm.synced_folder ".", "/vagrant", disabled: true
      
          # copy saved keys folder to /tmp directory 
          config.vm.provision "file", source: "files/ssh_keys", destination: "/tmp/ssh_keys"
     
          # Enable ssh forward agent
          config.ssh.forward_agent = true
      
          # put port_forwarding in place,  "to_a" is used in case port_forwarding key is missing for a box 
          servers['port_forwarding'].to_a.each do |port| 
              config.vm.network "forwarded_port", host: port['host_port'], guest: port['vm_port']
          end
    
          # install box level provisions       
          servers['provision'].to_a.each do |install_provision|
             config.vm.provision "shell", path: "#{install_provision}"
          end
    
    
          # conditional provisions
          if servers["type"] == "devbox"
             #config.vm.provision :shell, path: "provisions/install_apache.sh"
    	     config.vm.provision "shell", inline: "echo 'do these extra devbox steps'" 
          end
    
          if servers["type"] == "webserver"
             config.vm.provision "shell", inline: "echo 'do these extra webserver steps'" 
             #config.vm.provision :shell, path: "provisions/install_apache.sh"
          end
    
      end
  
    end
  
    config.vm.provision :hostmanager
  
end


