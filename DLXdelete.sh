#!/bin/bash
####
###
#    Make sure this script is always 640 on the deployment servers becaus3
#    it deletes ALL of the datalex directory with no questions asked!!
###
####

dt=`date +%T-%m%d%y`
cp /opt/datalex/totality/deploy.cfg /tmp/deploy.cfg-$dt
cp /etc/hosts /tmp/hosts.$dt

DpS="/opt/datalex/totality/deploy.cfg"

. $DpS

## sed -E "s/[[:space:]]+/,/g;" $i| sed -E '4,${/idle/d;}'

ASE=`grep 'TDP-APP-Server' /etc/hosts`
if [ "$ASE" ]; then
	sed -iE '/TDP-APP-Server/d' /etc/hosts
fi


ASE=`grep 'TDP-CUI-Server' /etc/hosts`
if [ "$ASE" ]; then
	sed -iE '/$CUIHOSTNAME/d' /etc/hosts
fi

ASE=`grep 'TDP-DB-Server' /etc/hosts`
if [ "$ASE" ]; then
	sed -iE '/TDP-DB-Server/d' /etc/hosts
fi


ASE=`grep 'TDP-Deploy-Server' /etc/hosts`
if [ "$ASE" ]; then
	sed -iE '/TDP-Deploy-Server/d' /etc/hosts
fi


ASE=`grep 'TDP-Mail-Server' /etc/hosts`
if [ "$ASE" ]; then
	sed -iE '/TDP-Mail-Server/d' /etc/hosts
fi

grep '^CUI=' $DpS | while read ue
do
  SVR=`echo $ue | cut -f2 -d'"'`
  echo "[$0] Stopping apache for server [$ue]..."
  /etc/init.d/httpd stop
  sleep 2
  killall -9 httpd
  echo "[$0] Stopping tomcat for server [$ue]..."
  /etc/init.d/tdpcontrol-tomcat stop
  sleep 2
  killall -9 java
  rm -f /etc/init.d/tdpcontrol-tomcat
  rm -f /etc/init.d/tdpcontrol
done

grep '^MUI=' $DpS | while read ue
do
  SVR=`echo $ue | cut -f2 -d'"'`
  echo "[$0] Stopping apache for server [$ue]..."
  /etc/init.d/httpd stop
  sleep 2
  killall -9 httpd
  echo "[$0] Stopping tomcat for server [$ue]..."
  /etc/init.d/tdpcontrol-tomcat stop
  sleep 2
  killall -9 java
  rm -f /etc/init.d/tdpcontrol-tomcat
  rm -f /etc/init.d/tdpcontrol
done

grep '^RST=' $DpS | while read ue
do
  SVR=`echo $ue | cut -f2 -d'"'`
  echo "[$0] Stopping WHAT?! for server [$ue]..."
  #ssh -oStrictHostKeyChecking=no root@$SVR 'bash -s' < "../installers/restsetup.sh"
done

grep '^TDP=' $DpS | while read ue
do
   SVR=`echo $ue | cut -f2 -d'"'`
   echo "[$0] Stopping jboss for server [$ue]..."
   /etc/init.d/tdpcontrol-jboss stop
  sleep 2
  killall -9 java
  rm -f /etc/init.d/tdpcontrol-jboss
  rm -f /etc/init.d/tdpcontrol
done

### Safegaurd the jenkins server - add others as needed
if [ "`hostname`" != "jbeclljki001" ]; then
   echo "Removing /opt/datalex symlink and directory structure..."
   rm -rf /opt/datalex
   rm -f /datalex
fi

