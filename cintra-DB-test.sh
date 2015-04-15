#!/bin/bash
# /opt/datalex/TDP_3_BRONZE_JBU_2607/tools/install/config/tdp-setup-config.xml

. ../deploy.cfg

dt=`date +%F:%T`

echo "[$0] Testing connection strings in the deploy.cfg file..."

cd $ODL/$DLX/tools/install/config


if [ ! -f "tdp-setup-config.xml" ]; then
	echo "tdp-setup-config.xml not found! Exiting!"
fi

#  Number of elements:  ${#ORCDB[@]}

index=0
ec=${#ORCDB[@]}

while [ "$index" -lt "$ec" ]
do    # iterate through the list of DB entries
echo "-----------------------=========================================================="
  echo ${ORCDB[$index]}
  oe=${ORCDB[$index]}
  VIP=`echo $oe | cut -d: -f1`
  PORT=`echo $oe | cut -d: -f2`
  USER=`echo $oe | cut -d: -f3`
  PW=`echo $oe | cut -d: -f4`
  SVC=`echo $oe | cut -d: -f5`
  SID=`echo $oe | cut -d: -f6`
  DBR=`echo $oe | cut -d: -f7`

echo "VIP=[$VIP] - [sqlplus $USER/$PW@(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=$ORCVIPNAME)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SVC)))" 

#sleep 2
sqlplus $USER/$PW@"(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=$ORCVIPNAME)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SVC)))" << !!
exit
!!
((index++))
echo "-----------------------"
done



echo "[$0] Completed!"

exit


#####
## sed -i "s/TDPserver/${TDPVIPNAME}/g" tdp-setup-config.xml
## sed -i "s/ORCserver/${ORCVIPNAME}/g" tdp-setup-config.xml
## This is a non-functional entry sicne there is is no reference to the MUI server in the tdp-set-config.xml : sed -i "s/MUIserver/${MUI}/g" tdp-setup-config.xml
## sed -i "s/CUIserver/${CUIVIPNAME}/g" tdp-setup-config.xml
## sed -i "s/MDBserver/${MDB}/g" tdp-setup-config.xml


