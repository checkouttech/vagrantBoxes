# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# # Require YAML module
require 'yaml'
#
# # Read YAML file with box details
servers = YAML.load_file('conf/yaml_file.yaml')


#print x = servers[0]['port_forwarding'][0]['vm_port']


servers[0]['port_forwarding'].each  { |h| puts h }



servers[0]['port_forwarding'].each  { |h| puts h['host_port'] }


servers[1]['port_forwarding'].each  { |h| puts h['host_port'] }


servers[2]['provision'].each do |h|
   puts h 
end


