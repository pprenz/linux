#!/bin/bash
# This script prepares the setup files and prompts so that when tdpConfig.sh -setup is run it defaults to the entries in the deploy.cfg
# /opt/datalex/TDP_CURRENT/tools/install/config/tdp-setup-config.xml

. ../deploy.cfg

dt=`date +%F:%T`

echo "[$0] Updating the tools/install/config/*setup xml files with the proper install info from 'deploy.cfg'" 

#cd $ODL/$DLX/tools/install/config
cd $ODL/$DLX/tools/install/config/setup_properties

echo "[`pwd`]"

FTE="jetBlue.setup.properties.xml TDPTaxCache.setup.properties.xml tdp.setup.properties.xml InstallTool.setup.properties.xml TDPAvailCache.setup.properties.xml BREImportTool.setup.properties.xml BRE.setup.properties.xml tdp-managementuserinterface.setup.properties.xml"


for fn in $FTE
do


echo "Processing file: [$fn]"

if [ ! -f "$FTE" ]; then
	echo "$FTE not found! Exiting!"
fi

#  Number of elements:  ${#ORCDB[@]}


index=0
ec=${#ORCDB[@]}

while [ "$index" -lt "$ec" ]
do    # iterate through the list of DB entries
  echo ${ORCDB[$index]}
  oe=${ORCDB[$index]}
  VIP=`echo $oe | cut -d: -f1`
  PORT=`echo $oe | cut -d: -f2`
  USER=`echo $oe | cut -d: -f3`
  PW=`echo $oe | cut -d: -f4`
  SVC=`echo $oe | cut -d: -f5`
  SID=`echo $oe | cut -d: -f6`
  DBR=`echo $oe | cut -d: -f7`

echo "[$VIP]"

#        <property Name="ConceptDB.database.password" Default="DLEX_INVENTORY" Prompt="false" />
#        <property Name="ConceptDB.database.username" Default="DLEX_INVENTORY" Prompt="false" />

  sed -i "s/\(${DBR}.database.host\" Default=\"\)\([^ ]\+\)\(\"\)/\1${VIP}\3/g" $fn
  sed -i "s/\(${DBR}.database.host\" Default=\"\)\(\"\)/\1${VIP}\2/g" $fn
  sed -i "s/\(${DBR}.database.host\" \)\(Prompt\)/\1Default=\"${VIP}\" \2/g" $fn

  sed -i "s/\(${DBR}.database.port\" Default=\"\)\([^ ]\+\)\(\"\)/\1${PORT}\3/g" $fn
  sed -i "s/\(${DBR}.database.port\" Default=\"\)\(\"\)/\1${PORT}\2/g" $fn

  sed -i "s/\(${DBR}.database.username\" Default=\"\)\([^ ]\+\)\(\"\)/\1${USER}\3/g" $fn
  sed -i "s/\(${DBR}.database.username\" Default=\"\)\(\"\)/\1${USER}\2/g" $fn

  sed -i "s/\(${DBR}.database.password\" Default=\"\)\([^ ]\+\)\(\"\)/\1${PW}\3/g" $fn
  sed -i "s/\(${DBR}.database.password\" Default=\"\)\(\"\)/\1${PW}\2/g" $fn

  sed -i "s/\(${DBR}.database.servicename\" Default=\"\)\([^ ]\+\)\(\"\)/\1${SVC}\3/g" $fn
  sed -i "s/\(${DBR}.database.servicename\" Default=\"\)\(\"\)/\1${SVC}\2/g" $fn
  sed -i "s/\(${DBR}.database.servicename\" \)\(Prompt\)/\1Default=\"${SVC}\" \2/g" $fn

  sed -i "s/\(${DBR}.database.sid\" Default=\"\)\([^ ]\+\)\(\"\)/\1${SID}\3/g" $fn
  sed -i "s/\(${DBR}.database.sid\" Default=\"\)\(\"\)/\1${SID}\2/g" $fn
  ((index++))
done


### App Server - TDP Server
sed -i "s/\(\"appserver.host\" Default=\"\)\([^ ]\+\)\(\"\)/\1${TDPVIPNAME}\3/g" $fn
sed -i "s/\(\"appserver.host\" Default=\"\)\(\"\)/\1${TDPVIPNAME}\2/g" $fn
sed -i "s/\(\"appserver.host\" \)\(Prompt\)/\1Default=\"${TDPVIPNAME}\" \2/g" $fn


### App Server - TDP Server PORT
sed -i "s/\(\"appserver.port\" Default=\"\)\([^ ]\+\)\(\"\)/\1${TDPVIPPORT}\3/g" $fn
sed -i "s/\(\"appserver.port\" Default=\"\)\(\"\)/\1${TDPVIPPORT}\2/g" $fn

## Mongo DB
sed -i "s/\(mongoDB.host\" Default=\"\)\([^ ]\+\)\(\"\)/\1${MDBVIPNAME}\3/g" $fn
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(mongoDB.host\" Default=\"\)\(\"\)/\1${MDBVIPNAME}\2/g" $fn
sed -i "s/\(mongoDB.host\" \)\(Prompt\)/\1Default=\"${MDBVIPNAME}\" \2/g" $fn

## CUI Server info: Any entry using this pattern has been found to want only the CUI VIP/host
sed -i "s/\(\"webserver.host\" Default=\"\)\([^ ]\+\)\(\"\)/\1${CUIVIPNAME}\3/g" $fn
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"webserver.host\" Default=\"\)\(\"\)/\1${CUIVIPNAME}\2/g" $fn
sed -i "s/\(\"webserver.host\" \)\(Prompt\)/\1Default=\"${CUIVIPNAME}\" \2/g" $fn

echo "Updating staticwebserver.host entries...."
#       <property Name="staticwebserver.host" Prompt="true" />
#        <property Name="staticwebserver.protocol" Prompt="true" />
sed -i "s/\(staticwebserver.host\" Default=\"\)\([^ ]\+\)\(\"\)/\1${CUIVIPNAME}\3/g" $fn
sed -i "s/\(staticwebserver.host\" Default=\"\)\(\"\)/\1${CUIVIPNAME}\2/g" $fn
sed -i "s/\(staticwebserver.host\" \)\(Prompt\)/\1Default=\"${CUIVIPNAME}\" \2/g" $fn

RWSH="resourcewebserver.host"
echo "Updating ${RWSH} entries...."
#       <property Name="${RWSH}" Prompt="true" />
sed -i "s/\(${RWSH}\" Default=\"\)\([^ ]\+\)\(\"\)/\1${CUIVIPNAME}\3/g" $fn
sed -i "s/\(${RWSH}\" Default=\"\)\(\"\)/\1${CUIVIPNAME}\2/g" $fn
sed -i "s/\(${RWSH}\" \)\(Prompt\)/\1Default=\"${CUIVIPNAME}\" \2/g" $fn

#protocol
RWSPENT="resourcewebserver.protocol"
echo "Updating $RSWPENT entries...."
#        <property Name="staticwebserver.protocol" Prompt="true" />
sed -i "s/\(${RWSPENT}\" Default=\"\)\([^ ]\+\)\(\"\)/\1${RESWEBSVRPROTO}\3/g" $fn
sed -i "s/\(${RWSPENT}\" Default=\"\)\(\"\)/\1${RESWEBSVRPROTO}\2/g" $fn
sed -i "s/\(${RWSPENT}\" \)\(Prompt\)/\1Default=\"${RESWEBSVRPROTO}\" \2/g" $fn

RWSPENT="staticwebserver.protocol"
echo "Updating $RSWPENT entries...."
#        <property Name="staticwebserver.protocol" Prompt="true" />
sed -i "s/\(${RWSPENT}\" Default=\"\)\([^ ]\+\)\(\"\)/\1${STATWEBSVRPROTO}\3/g" $fn
sed -i "s/\(${RWSPENT}\" Default=\"\)\(\"\)/\1${STATWEBSVRPROTO}\2/g" $fn
sed -i "s/\(${RWSPENT}\" \)\(Prompt\)/\1Default=\"${STATWEBSVRPROTO}\" \2/g" $fn

echo "Updating remoteStaticContent entries...."
#        <property Name="remoteStaticContent.url" Prompt="true" />
sed -i "s/\(remoteStaticContent.url\" Default=\"\)\([^ ]\+\)\(\"\)/\1${REMSTATICCONTURL}\3/g" $fn
sed -i "s/\(remoteStaticContent.url\" Default=\"\)\(\"\)/\1${REMSTATICCONTURL}\2/g" $fn
sed -i "s/\(remoteStaticContent.url\" \)\(Prompt\)/\1Default=\"${REMSTATICCONTURL}\" \2/g" $fn


## Mail Server info
## JBMAILHOSTNAME="mailrelay.jetblue.com"

echo "Updating mailserver entries...."

sed -i "s/\(mailserver.host\" Default=\"\)\([^ ]\+\)\(\"\)/\1${JBMAILHOSTNAME}\3/g" $fn
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(mailserver.host\" Default=\"\)\(\"\)/\1${JBMAILHOSTNAME}\2/g" $fn
sed -i "s/\(mailserver.host\" Default=\"\)\([^ ]\+\)\(\"\)/\1${JBMAILHOSTNAME}\3/g" $fn

sed -i "s/\(mailserver.host\" \)\(Prompt\)/\1Default=\"${JBMAILHOSTNAME}\" \2/g" $fn

echo "[$0] Completed!"

done
exit


#####
## sed -i "s/TDPserver/${TDPVIPNAME}/g" $fn
## sed -i "s/ORCserver/${ORCVIPNAME}/g" $fn
## This is a non-functional entry sicne there is is no reference to the MUI server in the tdp-set-config.xml : sed -i "s/MUIserver/${MUI}/g" $fn
## sed -i "s/CUIserver/${CUIVIPNAME}/g" $fn
## sed -i "s/MDBserver/${MDB}/g" $fn

