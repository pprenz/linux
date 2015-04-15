#!/bin/bash
#  /opt/datalex/TDP_3_BRONZE_JBU_2607/tools/deployment/deployments.xml

. ../deploy.cfg

p=`pwd`

echo "[$0] Updating deployments.xml-golden with the correct IPs from 'deploy.cfg' and creating a new $ODL/$DLX/tools/deployment/deployments.xml..."

if [ ! -d "$ODL/$DLX/tools/deployment" ]; then
   echo "ERROR: $ODL/$DLX/tools/deployment does not exist! Exiting"
   exit
fi

cd $ODL/$DLX/tools/deployment

if [ ! -f "deployments.xml-golden" ]; then
   echo "ERROR: deployments.xml-golden does NOT exist. - Create please then rerun - exiting!"
   exit
fi

rm -f deployments.xml 2>/dev/null
cp deployments.xml-golden deployments.xml

## Added 02/23/15 - Update the deployment server entry in the deploymets.xml file - TS
##         <Property name="DeployServerAddress" value="http://TDP-Deploy-Server"/>
echo "Updating deployment server entry: [$DPLSVR]"
sed -i "s/\(DeployServerAddress\" value=\"\)\(\"\)/\1${DPLSVR}\2/g" deployments.xml

sed -i "s/TDP-XXXX-VERSION/${DLX}/g" deployments.xml

grep -E "^CUI=|^MUI=|^RST=" $p/../deploy.cfg | while read ts
do
   hn=`echo "$ts" | cut -f2 -d'"'`
   echo "Editing 'deployments.xml' and adding server $hn to UI TIER"
   sed -iE "s/[[:space:]]TDP_UI_SVRS/\t\<Host name=\"${hn}\"\\/>\n\t\tTDP_UI_SVRS/" deployments.xml
done
sed -i "/TDP_UI_SVRS/d" deployments.xml

grep -E "^TDP=" $p/../deploy.cfg | while read ts
do
   hn=`echo "$ts" | cut -f2 -d'"'`
   echo "Editing 'deployments.xml' and adding server $hn to APP TIER"
   sed -iE "s/[[:space:]]TDP_APP_SVRS/\t\<Host name=\"${hn}\"\\/>\n\t\tTDP_APP_SVRS/" deployments.xml
done
sed -i "/TDP_APP_SVRS/d" deployments.xml

echo "[$0] Completed!"

