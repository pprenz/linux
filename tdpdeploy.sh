#!/bin/bash
# Created by Tanya S. - 09-19-14

. ../deploy.cfg

if [ ! "$1" ]; then
	echo "Please specify the TIER: TDP_UI_TIER or TDP_APP_TIER"
	exit
fi

TIER=$1

export JAVA_HOME=/opt/datalex/jdk

## This is required for the deployment process which datalex uses
 if [ ! -d "/var/www/html/tdp-deployment" ]; then
    mkdir /var/www/html/tdp-deployment
 fi

cd /opt/datalex/$DLX/tools/deployment

chmod 750 ./tdpDeployment.sh

echo "Disabling iptables temporarily..."
/etc/init.d/iptables stop

echo "Starting deployment..."
 ./tdpDeployment.sh -action deploy -name $TIER

echo "Enabling iptables..."
/etc/init.d/iptables stop

