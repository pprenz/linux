#!/bin/bash
mkdir  /tmp/datalexbak/ ;
#mkdir  /tmp/datalexbak.`date +"%Y%m%d%H"` ;
#this value will change maybe we should symlink the current build to /opt/datalex/TDP
#cp /opt/datalex/TDP_3_BRONZE_JBU_2502/tools/install/config/tdp-setup-config.xml /tmp/datalexbak.`date +"%Y%m%d%H"`/ ;
cp /opt/datalex/tdp/tools/install/config/tdp-setup-config.xml /tmp/datalexbak/
#cp /opt/datalex/TDP_3_BRONZE_JBU_2502/tools/deployment/deployments.xml /tmp/datalexbak.`date +"%Y%m%d%H"`/ ;
#functionality commented out as it will break on a new deploy
cp /opt/datalex/tdp/tools/deployment/deployments.xml /tmp/datalexbak/

