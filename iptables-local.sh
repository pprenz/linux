#!/bin/bash
###
### Create a script which fine tunes Iptables for the deployment server so as not to interfere with other apps
### Use this for now 'just to get it working' - as Nick says.
###
echo "Turning 'iptables' off..."
service iptables stop 
echo "Turning 'ip6tables' off..."
service ip6tables stop
echo "Disabling iptables service..."
chkconfig iptables off
echo "Disabling ip6tables service..."
chkconfig ip6tables off 


