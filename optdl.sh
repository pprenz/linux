#!/bin/bash
# This gets run on ALL of the servers being created

echo "====================="
echo "[$0] Running optdl.sh"

p=`pwd`

if [ -f "/tmp/deploy.cfg" ];then
   chmod 644 /tmp/deploy.cfg
   echo "[$0] Sourcing /tmp/deploy.cfg"
   p="/tmp"
elif [ -f "$p/deploy.cfg" ]; then
   echo "[$0] Sourcing $p/deploy.cfg"
   chmod 644 $p/deploy.cfg
else
   echo "$[0] ERROR: Cannot find deploy.cfg!!  Please correct and rerun"
   exit
fi

. $p/deploy.cfg

if [ ! -d "$ODL/totality" ]; then
   echo "[$0] Creating $ODL"
   mkdir -p $ODL/totality
else
   echo "[$0] [$ODL] and totality exists and this is a good thing... a very good thing!"
fi

if [ ! -h "/opt/datalex/tomcat" ]; then
   echo "[$0] Symlinking /opt/datalex/tomcat to /opt/datalex/apache-tomcat-6.0.35..."
   ln -s /opt/datalex/apache-tomcat-6.0.35 /opt/datalex/tomcat
fi

echo "[$0] Setting owner to $JBU:$JBG"
chown -R $JBU:$JBG $ODL

if [ ! -h "/datalex" ]; then
   echo "[$0] Symlinking $ODL to /datalex..."
   ln -s $ODL /datalex
fi

echo "[$0] Moving '$p/deploy.cfg' into the $ODL/totality directory"
mv $p/deploy.cfg $ODL/totality/

echo "[$0] End of optdl.sh"
