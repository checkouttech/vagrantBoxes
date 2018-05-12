

export JDK_PACKAGE=jdk-8u171-linux-x64.tar.gz

# download java 
#wget --quiet --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz"
wget --quiet --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/$JDK_PACKAGE"

export JAVA_HOME=/opt/java/
sudo mkdir $JAVA_HOME

#sudo tar -zxvf jdk-8u45-linux-x64.tar.gz   --strip-components 1  -C $JAVA_HOME
sudo tar -zxvf $JDK_PACKAGE   --strip-components 1  -C $JAVA_HOME

export PATH=$JAVA_HOME/bin:$PATH

#write to environment file for all future sessions 
sudo /bin/sh -c 'echo JAVA_HOME="/opt/java/" >> /etc/environment'
sudo /bin/sh -c '.  /etc/environment ; echo PATH="$JAVA_HOME/bin:$PATH" >> /etc/environment'

#sudo tar -xzf jdk-8u45-linux-x64.tar.gz -C /opt/
# export JAVA_HOME=/opt/jdk1.8.0_45


## Other option ( needs yum ) 
# working version 
#sudo yum -y  install java

