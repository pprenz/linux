#!/bin/bash
# Created by Tanya S. - 09-19-14

. ../deploy.cfg

OCP="${ODL}/$DLX/$CERTP"
CP="${ODL}/$DLX/CertPlat"

TD="/var/www/html/tdp-deployment"
RES="${TD}/resources"

echo "Removing $TD... Hope theres nothing of value in there!!  Oh well."
rm -rf $TD

yum -y install httpd
chkconfig --add httpd
chkconfig --level 2345 httpd on
/etc/init.d/httpd stop

chmod 755 "${OCP}"

# Create standard Certified Deployment symlink
if [ ! -h "${CP}" ]; then
    ln -s "$OCP" "${CP}"
fi

## Why is this redundant?
if [ ! -d "${TD}" ]; then
    mkdir ${TD}
fi

if [ ! -d "${RES}" ]; then
    mkdir ${RES}
fi

chmod -R 755 ${RES}

#if [ ! -d "/var/www/html/resources" ]; then
#    mkdir -p /var/www/html/resources
#fi

# Create ghost symlinks for future use of deployment scripts
jdkv="jdk1.6.0_45"
syms="apache-httpd.zip apache-tomcat-6.0.35.zip jboss-5.1.0.GA.zip $jdkv.zip modifyTomcatConfig.sh mod_jk.so"
for sl in $syms
do
   echo "chmod 644 ${CP}/${sl}"
   chmod 644 "${CP}/${sl}"
  if [ ! -h "${RES}/${sl}" ]; then
   echo "Symlinking $CP/$sl to $RES/$sl"
   ln -s "${CP}/${sl}"  "${RES}/${sl}"
  fi
done

p=`pwd`

cd ${ODL}
if [ ! -d "$jdkv" ]; then
   mkdir $jdkv 
fi
cd $jdkv
pwd
unzip -o ${CP}/$jdkv.zip
ln -s ${ODL}/$jdkv ${ODL}/jdk

cd $p
echo "[$0]: disabling iptables..."
./allsettings.sh

/etc/init.d/httpd stop
/etc/init.d/httpd start

