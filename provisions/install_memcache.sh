
# to install memcache
sudo yum -y install memcached
sudo yum install python-memcached

# to start memcache 
sudo systemctl restart memcached

# Notes
# memcache conf :  
## cat /etc/sysconfig/memcached
## memcached -l 127.0.0.1 -p 12345 -m 64 -vv
## memcached -h
## sudo yum install python-memcached
