#!/bin/bash
# /opt/datalex/TDP_3_BRONZE_JBU_2607/tools/install/beanpolicies.cfg

. ../deploy.cfg

#echo "THis is not needed any longer - the file ./rules/lib/beanpolicies.cfg contains the template which has been fixed for all future deploys"
#exit

dt=`date +%F:%T`

echo "[$0] Updating beanpolicies.cfg with the correct IPs from 'deploy.cfg' and creating a new $ODL/$DLX/tools/install/beanpolicies.cfg..."

cd $ODL/$DLX/tools/install


if [ ! -f "beanpolicies.cfg" ]; then
	echo "beanpolicies.cfg not found! Exiting!"
else
	echo "Backing up orig beanpolicies.cfg"
	cp beanpolicies.cfg beanpolicies.cfg.$dt
fi

# We are replacing the ' val="jdbc:oracle:thin:@${' with a double slash between the @ and the $
# And the 1521}:${ with 1521}/${
#<Property id="stagingDBURL" val="jdbc:oracle:thin:@//${jdbc/TDPBusinessRulesStagingDB.database.host}:${jdbc/TDPBusinessRulesStagingDB.database.port:1521}/${jdbc/TDPBusinessRulesStagingDB.database.servicename}"/>


sed -i "s/\:thin\:\@/\:thin\:\@\/\//g" beanpolicies.cfg
sed -i "s/1521}:/1521}\//g" beanpolicies.cfg
sed -i "s/1522}:/1522}\//g" beanpolicies.cfg
sed -i "s/database.sid/database.servicename/g" beanpolicies.cfg


echo "[$0] Completed!"

exit


#####
## sed -i "s/TDPserver/${TDPVIPNAME}/g" tdp-setup-config.xml
## sed -i "s/ORCserver/${ORCVIPNAME}/g" tdp-setup-config.xml
## This is a non-functional entry sicne there is is no reference to the MUI server in the tdp-set-config.xml : sed -i "s/MUIserver/${MUI}/g" tdp-setup-config.xml
## sed -i "s/CUIserver/${CUIVIPNAME}/g" tdp-setup-config.xml
## sed -i "s/MDBserver/${MDB}/g" tdp-setup-config.xml

