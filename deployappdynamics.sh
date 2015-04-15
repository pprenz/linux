#!/bin/bash





#this deploy out the appdynamics to a single server. specify in an ssh loop or move it to that server. It has no dependancies and pulls everything 
#from the web. It might later need a proxy server to be used if the firewalls get locked down ~Nick
uname -n

cd /opt/ ;wget -O jdk-8u5-linux-x64.tar.gz --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u5-b13/jdk-8u5-linux-x64.tar.gz; tar xvf jdk-8u5-linux-x64.tar.gz ; ln -s /opt/jdk1.8.0_05 /opt/jre ; cd /tmp/ ; curl -c cookies.txt -d 'username=David.Rosenberg@jetblue.com&password=JetBlueCTR2014' https://login.appdynamics.com/sso/login/ ;curl -O -b cookies.txt https://download.appdynamics.com/saas/public/latest/AppServerAgent-3.9.2.1.zip ;  curl -O -b cookies.txt   https://download.appdynamics.com/saas/public/latest/MachineAgent-3.9.2.1.zip ; mkdir -p /opt/appdynamics/MachineAgent/ ; mkdir -p /opt/appdynamics/Appagent/ ;  mv MachineAgent-3.9.2.1.zip /opt/appdynamics/MachineAgent/ ; mv AppServerAgent-3.9.2.1.zip /opt/appdynamics/Appagent/; cd /opt/appdynamics/Appagent/; unzip AppServerAgent-3.9.2.1.zip ;cd /opt/appdynamics/MachineAgent/;  unzip MachineAgent-3.9.2.1.zip; chown -R jbinst:jbinst /opt/appdynamics ;chown -R jbinst:jbinst /opt/jdk1.8.0_05;

#after using make sure to move the appdyn script file into the init.d folder on the destyintion host and manually add to chkconfig for service.
# also move the controller-info.xml to the /opt/appdynamics/MachineAgent/conf/ folder before starting
