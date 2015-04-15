#!/bin/bash
# /opt/datalex/TDP_3_BRONZE_JBU_2607/tools/install/config/tdp-setup-config.xml

. ../deploy.cfg

dt=`date +%F:%T`

echo "[$0] Updating tdp-setup-config.xml with the correct IPs from 'deploy.cfg' and creating a new $ODL/$DLX/tools/install/config/tdp-setup-config.xml..."

cd $ODL/$DLX/tools/install/config


if [ ! -f "tdp-setup-config.xml" ]; then
	echo "tdp-setup-config.xml not found! Exiting!"
fi

#  Number of elements:  ${#ORCDB[@]}

index=0
ec=${#ORCDB[@]}

tcf="tdp-setup-config.xml"
echo "[Begin $tcf sction...]"

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

  sed -i "s/\(${DBR}.database.host\" Value=\"\)\([^ ]\+\)\(\"\)/\1${VIP}\3/g" $tcf
  sed -i "s/\(${DBR}.database.host\" Value=\"\)\(\"\)/\1${VIP}\2/g" $tcf

  sed -i "s/\(${DBR}.database.port\" Value=\"\)\([^ ]\+\)\(\"\)/\1${PORT}\3/g" $tcf
  sed -i "s/\(${DBR}.database.port\" Value=\"\)\(\"\)/\1${PORT}\2/g" $tcf

  sed -i "s/\(${DBR}.database.username\" Value=\"\)\([^ ]\+\)\(\"\)/\1${USER}\3/g" $tcf
  sed -i "s/\(${DBR}.database.username\" Value=\"\)\(\"\)/\1${USER}\2/g" $tcf

  sed -i "s/\(${DBR}.database.password\" Value=\"\)\([^ ]\+\)\(\"\)/\1${PW}\3/g" $tcf
  sed -i "s/\(${DBR}.database.password\" Value=\"\)\(\"\)/\1${PW}\2/g" $tcf

  sed -i "s/\(${DBR}.database.servicename\" Value=\"\)\([^ ]\+\)\(\"\)/\1${SVC}\3/g" $tcf
  sed -i "s/\(${DBR}.database.servicename\" Value=\"\)\(\"\)/\1${SVC}\2/g" $tcf

  sed -i "s/\(${DBR}.database.sid\" Value=\"\)\([^ ]\+\)\(\"\)/\1${SID}\3/g" $tcf
  sed -i "s/\(${DBR}.database.sid\" Value=\"\)\(\"\)/\1${SID}\2/g" $tcf
  ((index++))
done

### App Server - TDP Server
sed -i "s/\(appserver.host\" Value=\"\)\([^ ]\+\)\(\"\)/\1${TDPVIPNAME}\3/g" $tcf
sed -i "s/\(appserver.host\" Value=\"\)\(\"\)/\1${TDPVIPNAME}\2/g" $tcf

### App Server - TDP Server PORT
sed -i "s/\(appserver.port\" Value=\"\)\([^ ]\+\)\(\"\)/\1${TDPVIPPORT}\3/g" $tcf
sed -i "s/\(appserver.port\" Value=\"\)\(\"\)/\1${TDPVIPPORT}\2/g" $tcf

## Mongo DB
sed -i "s/\(mongoDB.host\" Value=\"\)\([^ ]\+\)\(\"\)/\1${MDBVIPNAME}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(mongoDB.host\" Value=\"\)\(\"\)/\1${MDBVIPNAME}\2/g" $tcf

## CUI Server info: Any entry using this pattern has been found to want only the CUI VIP/host
sed -i "s/\(webserver.host\" Value=\"\)\([^ ]\+\)\(\"\)/\1${CUIVIPNAME}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(webserver.host\" Value=\"\)\(\"\)/\1${CUIVIPNAME}\2/g" $tcf

## Mail Server info
## JBMAILHOSTNAME="mailrelay.jetblue.com"

sed -i "s/\(mailserver.host\" Value=\"\)\([^ ]\+\)\(\"\)/\1${JBMAILHOSTNAME}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(mailserver.host\" Value=\"\)\(\"\)/\1${JBMAILHOSTNAME}\2/g" $tcf

#<property Name="start.new.search.homepage.url" Value="https://10.23.6.245/jetBlue/DatalexGatewayAir.htm"/> change to http://jbccllappc950.jetblue.local/jetBlue/ApplicationStartAction.do
sed -i "s/\(start.new.search.homepage.url\" Value=\"\)\([^ ]\+\)\(\"\)/\1${STARTNEWSEARCH}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(start.new.search.homepage.url\" Value=\"\)\(\"\)/\1${STARTNEWSEARCH}\2/g" $tcf

#<property Name="web.profile.sso.url" Value="https://b62-int.jetblue.com/B6.auth/"/>
sed -i "s/\(web.profile.sso.url\" Value=\"\)\([^ ]\+\)\(\"\)/\1${WEBPROFILESSOURL}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(web.profile.sso.url\" Value=\"\)\(\"\)/\1${WEBPROFILESSOURL}\2/g" $tcf

#<property Name="default.pos.code" Value="B6"/>
sed -i "s/\(default.pos.code\" Value=\"\)\([^ ]\+\)\(\"\)/\1${DEFPOSCODE}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(default.pos.code\" Value=\"\)\(\"\)/\1${DEFPOSCODE}\2/g" $tcf

#<property Name="webserver.scheme" Value="" ReleaseDefault=""/>
sed -i "s/\(\"webserver.scheme\" Value=\"\)\([^ ]\+\)\(\"\)/\1${WEBSERVERSCHEME}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"webserver.scheme\" Value=\"\)\(\"\)/\1${WEBSERVERSCHEME}\2/g" $tcf

#<property Name="sso.cookie.maxAge" Value="-1" ReleaseDefault="-1"/>
#SSOCOOKIEMAXAGE="20"
sed -i "s/\(\"sso.cookie.maxAge\" Value=\"\)\([^ ]\+\)\(\"\)/\1${SSOCOOKIEMAXAGE}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"sso.cookie.maxAge\" Value=\"\)\(\"\)/\1${SSOCOOKIEMAXAGE}\2/g" $tcf

#<property Name="sso.cookie.domain" Value="WHATAREMYCOOKIEDOMAINSHELPME" ReleaseDefault=""/>
SCD="sso.cookie.domain"
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${SSOCOOKIEDOMAIN}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${SSOCOOKIEDOMAIN}\2/g" $tcf

#        <property Name="staticwebserver.protocol" Prompt="true" />
SCD="resourcewebserver.protocol"
echo "Updating $SCD entries...."
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${RESWEBSVRPROTO}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${RESWEBSVRPROTO}\2/g" $tcf

### **** This should ALWAYS be localhost unless it is a single server environment
SCD="resourcewebserver.host"
## CUI Resource Webserver info: specific to the resourcewebserver entry
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${RESWEBSVRHOST}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${RESWEBSVRHOST}\2/g" $tcf

SCD="staticwebserver.protocol"
echo "Updating $SCD entries...."
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${STATWEBSVRPROTO}\3/g" $tcf
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${STATWEBSVRPROTO}\2/g" $tcf

SCD="webserver.protocol"
echo "Updating $SCD entries...."
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${GENWEBSVRPROTO}\3/g" $tcf
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${GENWEBSVRPROTO}\2/g" $tcf

SCD="remoteStaticContent.url"
echo "Updating $SCD entries...."
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${REMSTATICCONTURL}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${REMSTATICCONTURL}\2/g" $tcf


##<property Name="jetblue.profile.host" Value="https://216.178.224.120/profile2" ReleaseDefault="https://216.178.224.120/profile2"/>
SCD="jetblue.profile.host"
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${JBPROFILEHOST}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${JBPROFILEHOST}\2/g" $tcf

#<property Name="hertz2007a.url" Value="T071" ReleaseDefault="https://vv.xqual.hertz.com/DirectLinkWEB/handlers/DirectLinkHandler?id=ota2007a"/>
SCD="hertz2007a.url"
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${HRTZ2007AURL}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${HRTZ2007AURL}\2/g" $tcf

##<property Name="mondial.cancellation.url" Value="http://213.41.31.43:8080/gateway/cancellationService.slt" ReleaseDefault="http://213.41.31.43:8080/gateway/cancellationService.slt"/>
SCD="mondial.cancellation.url"
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${MONDIALCANCELURL}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${MONDIALCANCELURL}\2/g" $tcf

#<property Name="mondial.quotation.url" Value="http://213.41.31.43:8080/gateway/pricing" ReleaseDefault="http://213.41.31.43:8080/gateway/pricing"/>
SCD="mondial.quotation.url"
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${MONDIALQUOTEURL}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${MONDIALQUOTEURL}\2/g" $tcf

#<property Name="mondial.subscription.url" Value="http://uat.magroup-webservice.com/gateway/subscription" ReleaseDefault="http://213.41.31.43:8080/gateway/subscription"/>
SCD="mondial.subscription.url"
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${MONDIALSUBURL}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${MONDIALSUBURL}\2/g" $tcf

#<property Name="tokenserver.host" Value="jbccllappc950.jetblue.local"/>
SCD="tokenserver.host"
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${TOKENSVRHOST}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${TOKENSVRHOST}\2/g" $tcf

#<property Name="tokenserver.port" Value="7071"/>
SCD="tokenserver.port"
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${TOKENSVRPORT}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${TOKENSVRPORT}\2/g" $tcf

#<property Name="tokenserver.scheme" Value="https" ReleaseDefault="https"/>
SCD="tokenserver.scheme"
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${TOKENSVRSCHEME}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${TOKENSVRSCHEME}\2/g" $tcf

#<property Name="comarch_host_url" Value="https://216.178.224.120/profile/comarch/redemption2" ReleaseDefault="https://216.178.224.120/profile/comarch/redemption2"/>
#SCD="comarch_host_url"
#sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${COMARCHHOSTURL}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
#sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${COMARCHHOSTURL}\2/g" $tcf

### Beginning of new array consolidation section
index=0
ec=${#TDPXML[@]}

tcf="tdp-setup-config.xml"
echo "[Begin $tcf field section...]"

while [ "$index" -lt "$ec" ]
do    # iterate through the list of DB entries
  echo ${TDPXML[$index]}
  te=${TDPXML[$index]}
  pn=`echo $te | cut -d= -f1`
  vl=`echo $te | cut -d= -f2`

  echo "[$pn] [$vl]"

  sed -i "s/\(\"${pn}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${vl}\3/g" $tcf
  sed -i "s/\(\"${pn}\" Value=\"\)\(\"\)/\1${vl}\2/g" $tcf
  ((index++))
done


for xmle in memcached.avail.servers~$MAS memcached.farequote.servers~$MFS memcached.faresearchsv.servers~$MSS
do
echo "Updating $xmle..."
SCD=`echo $xmle | cut -d~ -f1`
SCE=`echo $xmle | cut -d~ -f2`
sed -i "s/\(\"${SCD}\" Value=\"\)\([^ ]\+\)\(\"\)/\1${SCE}\3/g" $tcf
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(\"${SCD}\" Value=\"\)\(\"\)/\1${SCE}\2/g" $tcf
done

###
### This is for the B6.xml (was previous to Sprint11 jetBlue.xml) file or any other tomcat conf

cd $ODL/$DLX/tomcat/conf/Catalina/localhost

#<Context path="/jetBlue" docBase="${catalina.home}/webapps/B6" sessionCookieDomain=".gl.datalex.jetblue.com">
SCD="sessionCookieDomain"
sed -i "s/\(${SCD}=\"\)\([^ ]\+\)\(\"\)/\1${SESSCOOKIEDOM}\3/g" B6.xml
## This is because sometimes there is NO characters in between the quotes and the above sed doesn't see it
sed -i "s/\(${SCD}=\"\)\(\"\)/\1${SESSCOOKIEDOM}\2/g" B6.xml

# APACHE!!

cd $ODL/$DLX/apache/conf.d

SCD="worker.tdpworker.port"
sed -i "s/\(${SCD}=\).*$/\1${TDPWORKERPORT}/g" worker.properties

echo "[$0] Completed!"

exit


#####
## sed -i "s/TDPserver/${TDPVIPNAME}/g" tdp-setup-config.xml
## sed -i "s/ORCserver/${ORCVIPNAME}/g" tdp-setup-config.xml
## This is a non-functional entry sicne there is is no reference to the MUI server in the tdp-set-config.xml : sed -i "s/MUIserver/${MUI}/g" tdp-setup-config.xml
## sed -i "s/CUIserver/${CUIVIPNAME}/g" tdp-setup-config.xml
## sed -i "s/MDBserver/${MDB}/g" tdp-setup-config.xml

