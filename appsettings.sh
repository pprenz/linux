#!/bin/bash

if [ -f "/opt/datalex/totality/deploy.cfg" ]; then
	echo "[$0] deploy.cfg found! [/opt/datalex/totality/deploy.cfg]... continuing"
else
	echo "[$0] ERROR!! /opt/datalex/totality/deploy.cfg not found! Fix and rerun this script. Exiting!"
fi

. /opt/datalex/totality/deploy.cfg

FN="/etc/sysctl.conf"

echo "[$0] Updating sysctl.conf entries..."

X=`grep net.ipv4.tcp_keepalive_intvl $FN`
if [ "$X" ]; then
	sed -iE '/net.ipv4.tcp_keepalive_intvl/d' $FN
fi
echo "net.ipv4.tcp_keepalive_intvl = 30" >> $FN


X=`grep net.ipv4.tcp_keepalive_probes $FN`
if [ "$X" ]; then
	sed -iE '/net.ipv4.tcp_keepalive_probes/d' $FN
fi
echo "net.ipv4.tcp_keepalive_probes = 2" >> $FN


X=`grep net.ipv4.tcp_keepalive_time $FN`
if [ "$X" ]; then
	sed -iE '/net.ipv4.tcp_keepalive_time/d' $FN
fi
echo "net.ipv4.tcp_keepalive_time = 30 " >> /etc/sysctl.conf

echo "[$0] Enabling sysctl entries... [IGNORE ERRORS AND WARNINGS!!]"
sysctl -p /etc/sysctl.conf


