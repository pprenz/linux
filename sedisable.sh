#!/bin/bash

echo "Disabling selinux..."
setenforce Permissive

sed -i "/SELINUX=/d" /etc/sysconfig/selinux

echo "SELINUX=permissive" >> /etc/sysconfig/selinux

sestatus

