#!/bin/bash
#

echo "[$0] Turning 'iptables' off..."
service iptables stop 
echo "[$0] Turning 'ip6tables' off..."
service ip6tables stop
echo "[$0] Disabling iptables service..."
chkconfig iptables off
echo "[$0] Disabling ip6tables service..."
chkconfig ip6tables off 

