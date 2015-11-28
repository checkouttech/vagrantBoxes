sudo systemctl stop firewalld

sudo yum update

sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF


sudo yum install -y docker-engine   

sudo service docker start

sudo docker run -d \
  --name graphite \
  --restart=always \
  -p 81:80 \
  -p 2003:2003 \
  -p 8125:8125/udp \
  -p 8126:8126 \
  hopsoft/graphite-statsd


sudo yum install -y https://grafanarel.s3.amazonaws.com/builds/grafana-2.5.0-1.x86_64.rpm

sudo docker restart graphite

sudo service grafana-server start

curl 'http://admin:admin@localhost:3000/api/datasources' -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"name":"localGraphite","type":"graphite","url":"http://localhost:81","access":"proxy","isDefault":true,"database":"asd"}'



#wget http://grafanarel.s3.amazonaws.com/builds/grafana-2.1.0-pre1.x86_64.rpm

#sudo rpm -ivh grafana-2.1.0-pre1.x86_64.rpm


#curl 'http://admin:admin@192.168.99.100:3000/api/datasources' -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"name":"localGraphite","type":"graphite","url":"http://192.168.99.100","access":"proxy","isDefault":true,"database":"asd"}'





