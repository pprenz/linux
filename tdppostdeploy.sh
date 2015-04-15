#!/bin/bash
#  deploy.cfg must contain a separate entry for each server at this point. Ideally we should have ONE line with multiple IPs/Hostnames

. ../deploy.cfg

DpS=".."

while [ "$1" ]; do
  if [ "$1" == "-tier" ]; then
	shift
	TIER=$1
	shift
  elif [ "$1" == "-all" ]; then
	shift
	TIER=ALL
  elif [ "$1" == "" -o "$1" == "-?" ]; then
	echo "USAGE: $0 [-tier [APP|ALL|CUI|MUI|MCH] | [ -all]"
  fi
  shift
done

echo "Running $0 for $TIER.."
	
if [ "$TIER" == "APP" -o "$TIER" == "ALL" ]; then
for SVR in `cat tdpserver.lst`
do
   echo "[$0] Running jbosssetup for server [$SVR]..."
   su - $JBU -c "scp ${ODL}/${DLX}/totality/scripts/tdpcontrol-jboss root@$SVR:${ODL}/totality"
   su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$SVR 'mkdir ${ODL}/JBcerts'"
   su - $JBU -c "scp ${ODL}/${DLX}/JBcerts/*.cer root@$SVR:${ODL}/JBcerts"
   su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$SVR 'chown -R jbinst:jbinst /opt/datalex''"
   su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$SVR 'rm -f /opt/datalex/tomcat'"
   su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$SVR 'bash -s' < ${ODL}/${DLX}/totality/installers/jbosssetup.sh"
done
fi


if [ "$TIER" == "CUI" -o "$TIER" == "ALL" ]; then
for SVR in `cat uiserver.lst | grep -E "cui|tbl"`
do
  echo "[$0] Running cuisetup for server [$SVR]..."
  su - $JBU -c "scp ${ODL}/${DLX}/CertPlat/mod_jk.so root@$SVR:${ODL}/apache"
   su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$SVR 'mkdir ${ODL}/JBcuicerts'"
   su - $JBU -c "scp ${ODL}/${DLX}/JBcuicerts/*.crt root@$SVR:${ODL}/JBcuicerts"
  su - $JBU -c "scp ${ODL}/${DLX}/totality/scripts/tdpcontrol-tomcat root@$SVR:${ODL}/totality"
  #ssh -oStrictHostKeyChecking=no root@$SVR "if [ ! -h /etc/httpd/modules/mod_jk.so ]; then ln -s ${ODL}/apache/mod_jk.so /etc/httpd/modules; fi; chmod 755 ${ODL}/apache/mod_jk.so"
  su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$SVR 'bash -s' < ${ODL}/${DLX}/totality/installers/cuisetup.sh"
done
fi

#grep '^MUI=' $DpS/deploy.cfg | while read ue
if [ "$TIER" == "MUI" -o "$TIER" == "ALL" ]; then
for SVR in `cat uiserver.lst | grep mui`
do
  echo "[$0] Running muisetup for server [$SVR]..."
  su - $JBU -c "scp ${ODL}/${DLX}/CertPlat/mod_jk.so root@$SVR:${ODL}/apache"
  su - $JBU -c "scp ${ODL}/${DLX}/totality/scripts/tdpcontrol-tomcat root@$SVR:${ODL}/totality"
  #ssh -oStrictHostKeyChecking=no root@$SVR "if [ ! -h /etc/httpd/modules/mod_jk.so ]; then ln -s ${ODL}/apache/mod_jk.so /etc/httpd/modules; fi; chmod 755 ${ODL}/apache/mod_jk.so"
  su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$SVR 'bash -s' < ${ODL}/${DLX}/totality/installers/muisetup.sh"
done
fi

#grep '^RST=' $DpS/deploy.cfg | while read ue
if [ "$TIER" == "RST" -o "$TIER" == "ALL" ]; then
for SVR in `cat rstserver.lst | grep mui`
do
   SVR=`echo $ue | cut -f2 -d'"'`
  echo "[$0] Running restsetup for server [$SVR]..."
  su - $JBU -c "scp ${ODL}/${DLX}/CertPlat/mod_jk.so root@$SVR:${ODL}/apache"
  su - $JBU -c "scp ${ODL}/${DLX}/totality/scripts/tdpcontrol-tomcat root@$SVR:${ODL}/totality"
  #ssh -oStrictHostKeyChecking=no root@$SVR "if [ ! -h /etc/httpd/modules/mod_jk.so ]; then ln -s ${ODL}/apache/mod_jk.so /etc/httpd/modules; fi; chmod 755 ${ODL}/apache/mod_jk.so"
  su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$SVR 'bash -s' < ${ODL}/${DLX}/totality/installers/restsetup.sh"
done
fi

if [ "$TIER" == "MCH" -o "$TIER" == "ALL" ]; then
## New stanza for memcached servers - 013115 - TS
#grep -E '^MCH[A-Z]=' $DpS/deploy.cfg | while read ue
for SVR in `cat dbserver.lst`
do
  # SVR=`echo $ue | cut -f2 -d'"'`
  echo "[$0] Running memcached setup for server [$SVR]..."
  su - $JBU -c "scp ${ODL}/${DLX}/totality/installers/memcached.port root@$SVR:/etc/init.d"
  su - $JBU -c "ssh -t root@$SVR mv -f /etc/init.d/memcached /etc/init.d/memcached.orig 2> /dev/null"
  su - $JBU -c "ssh -T -oStrictHostKeyChecking=no root@$SVR 'bash -s' < ${ODL}/${DLX}/totality/installers/mcachesetup.sh"
### We could check with this: nc -w 1 jbecllmchc480 11212; echo $?  - write a verify script
done
fi
