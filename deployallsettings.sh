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

for i in `cat tdpserver.lst uiserver.lst dbserver.lst`
 do
   echo "Server: [$i]"
   su - $JBU -c "scp -oStrictHostKeyChecking=no $ODL/$DLX/totality/deploy.cfg root@$i:/tmp"
   su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$i 'bash -s' < $ODL/$DLX/totality/scripts/sedisable.sh"
   su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$i 'bash -s' < $ODL/$DLX/totality/scripts/allsettings.sh"
   su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$i 'bash -s' < $ODL/$DLX/totality/scripts/optdl.sh"
   echo "NOT Running create-etchosts.sh since all hosts and VIPS should be resolvable via DNS create-etchosts.sh moved to .archive"
#   su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$i 'bash -s' < $ODL/$DLX/totality/scripts/create-etchosts.sh"
 done
