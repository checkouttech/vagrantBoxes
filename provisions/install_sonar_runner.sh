#!/usr/bin/env bash

wget http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip
sudo unzip sonar-runner-dist-*.zip  -d /opt/
sudo ln -s /opt/sonar-runner-*  /opt/sonar-runner

