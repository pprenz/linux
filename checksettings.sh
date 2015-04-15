#!/bin/bash
echo "=============================================="
uname -n 
echo "----- CHECK SYSCTL.CONF -------" 
# tail -n 3 /etc/sysctl.conf
grep 'net.ipv4.tcp_keepalive_intvl' /etc/sysctl.conf
grep 'net.ipv4.tcp_keepalive_time' /etc/sysctl.conf
grep 'net.ipv4.tcp_keepalive_probes' /etc/sysctl.conf
echo "----- CHECK IPTABLES SERVICE -----------"
 service iptables status
echo "------CHECK IPTABLES STARTUP LEVELS -----------"
 chkconfig --list |grep tables
echo "=============================================="

