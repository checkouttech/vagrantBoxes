
# pylot 
sudo yum install unzip
sudo pip install -U  numpy
sudo pip install -U  python-dev
sudo yum install  numpy-1.7.1-10.el7.src.rpm
sudo yum install numpy
sudo yum install Matplotlib
sudo yum install python-matplotlib


# siege 
wget http://download.joedog.org/siege/siege-latest.tar.gz
tar -zxvf siege-latest.tar.gz
cd siege-*/
sudo ./configure
sudo make
sudo make install


# gatling
sudo -u jenkins  wget  https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/2.1.7/gatling-charts-highcharts-bundle-2.1.7-bundle.zip  .
sudo -u jenkins  unzip -o gatling-charts-highcharts-bundle-2.1.7-bundle.zip





