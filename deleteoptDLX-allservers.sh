#!/bin/bash
# Copy old deploy.cfg to /tmp just in case

./mklists.sh

for i in `cat uiserver.lst tdpserver.lst`
 do
   echo "Removing /opt/datalex from server [$i]..."
   ssh -oStrictHostKeyChecking=no root@$i 'bash -s' < ./DLXdelete.sh
 done
