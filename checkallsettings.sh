#!/bin/bash
for i in `cat tdpserver.lst uiserver.lst dbserver.lst`
 do
   ssh -oStrictHostKeyChecking=no root@$i 'bash -s' < ./checksettings.sh
 done
