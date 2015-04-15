#!/bin/bash
. ../deploy.cfg
./mklists.sh

for i in `cat uiserver.lst tdpserver.lst dbserver.lst`
   do 
   echo $i
   if [ "$UID" -eq 0 ]; then
   su - jbinst -c "ssh root@$i 'ps -ef | grep java'"
   else
   ssh root@$i 'ps -ef | grep java'
   fi
 done

