#!/bin/bash
# Copy old deploy.cfg to /tmp just in case

dt=`date +%y%m%d%H%M`

./mklists.sh

for i in `cat uiserver.lst tdpserver.lst`
 do
   echo "=============================================="
   echo "Tar'ing /opt/datalex on server [$i]..."
   ssh -oStrictHostKeyChecking=no root@$i 'bash -s' < backupODLX.sh
 done
