#!/bin/bash

if [ -f "../deploy.cfg" ]; then
   echo "[$0] OK - deploy.cfg exists and we are ready to rock and roll!"
else
   echo "[$0] ERROR!!! ../deploy.cfg does NOT exist.  Please create and rerun this script."
   exit
fi

. ../deploy.cfg

./mklists.sh

dir=`pwd`

for i in `cat tdpserver.lst`
 do
   echo "[$0] Running appsettings.sh for server $i..."
   su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$i 'bash -s' < $ODL/$DLX/totality/scripts/appsettings.sh"
 done
