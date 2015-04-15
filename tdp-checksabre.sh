#!/bin/bash

#sabre.domain=B6
#sabre.max_pool_size=250
#sabre.organization=B6
##sabre.password=R39TUY3H
#sabre.password=TDP1234
#sabre.pcc=NIH
##sabre.ticketing_url=https://sws-crt.cert.sabre.com
#sabre.ticketing_url=https://etb.prd.ecl.ctr.jetblue.local:7575
#sabre.timeout=60000
#sabre.url=https://sws-crt.as.cert.sabre.com/B6CTR
#sabre.username=100007
#

echo "[$UID]"
. ../deploy.cfg
./mklists.sh

TDPC="/opt/datalex/jboss/server/default/TDP-config"
TDPP="tdp.beanpolicies.properties"

for i in `cat tdpserver.lst`
 do 
 echo "[$i]"
 if [ "$UID" > 0  ]; then
 ssh root@$i "grep sabre.url $TDPC/$TDPP | grep -v '^#'; grep sabre.username $TDPC/$TDPP | grep -v '^#'; grep sabre.password $TDPC/$TDPP | grep -v '^#'"
else
 su - jbinst -c ssh root@$i "grep sabre.url $TDPC/$TDPP | grep -v '^#'; grep sabre.username $TDPC/$TDPP | grep -v '^#'; grep sabre.password $TDPC/$TDPP | grep -v '^#'"
 fi
 done

