


# download java

#export JDK_PACKAGE=jdk-8u171-linux-x64.tar.gz
#export JDK_PACKAGE=jdk-14.0.2_linux-x64_bin.tar.gz

#wget --quiet --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/$JDK_PACKAGE"
#wget --quiet --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz"



# download open java

export JDK_PACKAGE=openjdk-14.0.2_linux-x64_bin.tar.gz

wget --quiet https://download.java.net/java/GA/jdk14.0.2/205943a0976c4ed48cb16f1043c5c647/12/GPL/$JDK_PACKAGE



export JAVA_HOME=/opt/java/
sudo mkdir $JAVA_HOME

#sudo tar -zxvf jdk-8u45-linux-x64.tar.gz   --strip-components 1  -C $JAVA_HOME
sudo tar -zxf $JDK_PACKAGE   --strip-components 1  -C $JAVA_HOME

# setup paths
export PATH=$JAVA_HOME/bin:$PATH

#write to environment file for all future sessions
sudo /bin/sh -c 'echo JAVA_HOME="/opt/java/" >> /etc/environment'
sudo /bin/sh -c '.  /etc/environment ; echo PATH="$JAVA_HOME/bin:$PATH" >> /etc/environment'

## Other option ( needs yum )
# working version
#sudo yum -y  install java

