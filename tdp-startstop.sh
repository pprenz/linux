#!/bin/bash
#  deploy.cfg must contain a separate entry for each server at this point. Ideally we should have ONE line with multiple IPs/Hostnames

. ../deploy.cfg

DpS=".."

echo "Running mklists.sh to ensure that the server tiers are up to date..."
./mklists.sh

if [ "$1" == "stop" ]; then
	sw=$1
elif [ "$1" == "start" ]; then
	sw=$1
elif [ "$1" == "status" ]; then
	sw=$1
else
	echo "ERROR: Please specify start or stop as the first parameter"
	exit
fi

shift

if [ "$1" == "-all" ]; then
   	LST=`cat tdpserver.lst uiserver.lst`
elif [ "$1" == "-tier" ]; then
	shift
	if [ "$1" == "TDP_APP_TIER" ]; then
		LST=`cat tdpserver.lst`
		shift
	fi
	if [ "$1" == "TDP_UI_TIER" ]; then
		LST="$LST `cat uiserver.lst`"
		shift
	fi
elif [ "$1" == "-host" ]; then
	shift
	LST=$@
else
	echo "USAGE: $0 [start|stop] [-all = All servers in TDP and UI tier] [-tier TDP_APP_TIER|TDP_UI_TIER] [ -host hostnames ]"
	exit
fi

echo "${sw}'ing.... :-)"



for SVR in $LST
do
  ss=`grep -v "^#" ../deploy.cfg | grep -i $SVR | cut -f1 -d"="`
  if [ "$ss" == "TDP" ]; then
	app="jboss"
  else
	app="tomcat"
  fi
  echo "[$ss $app]:"
  echo "[$0] Running $sw for server [$SVR]..." 
if [ "$sw" == "stop" ]; then
  echo "Stopping HTTPD for $SVR"
#    ssh -oStrictHostKeyChecking=no root@$SVR "/etc/init.d/httpd stop"
    sleep 2
  echo "Soft Killing HTTPD for $SVR"
#    ssh -oStrictHostKeyChecking=no root@$SVR "killall httpd"
  echo "[$sw] TDP using tdpcontrol-${app} for $SVR"
    su - jbinst -c "ssh -oStrictHostKeyChecking=no root@$SVR \"/etc/init.d/tdpcontrol-${app} ${sw}\""
    sleep 1

elif [ "$sw" == "start" ]; then

  echo "[$sw] HTTPD for $SVR"
#    ssh -oStrictHostKeyChecking=no root@$SVR "/etc/init.d/httpd ${sw}"
    sleep 2
  echo "[$sw] TDP using tdpcontrol-${app} for $SVR"
    su - jbinst -c "ssh -oStrictHostKeyChecking=no root@$SVR \"/etc/init.d/tdpcontrol-${app} ${sw}\""

elif [ "$sw" == "status" ]; then
	echo "Getting ${sw} for $SVR"
	if [ "$ss" == "CUI" ]; then
           su - jbinst -c "ssh -oStrictHostKeyChecking=no root@$SVR \"/etc/init.d/httpd ${sw}\""
	fi
    	su - jbinst -c "ssh -oStrictHostKeyChecking=no root@$SVR \"/opt/datalex/totality/tdpcontrol-${app} ${sw}\""
fi
	
	
done
