#!/bin/bash
dt=`date date +%F:%T`

dlxftp="ftp.datalex.ie"
did="jblue"
dpw="wr5KuzasT"

TL="/opt/datalex/jboss/server/default/log"

./mklists.sh

while [ "$1" ];
do
 if [ "$1" == "-p" ]; then
    shift
    LP=$1
    shift
 elif [ "$1" == "-l" ]; then
    for sn in `cat tdpserver.lst`
	do
	echo "--------------------------  $sn -------------------------------"
	ssh root@$sn "ls -al $TL/*.log*"
	done
    exit
 elif [ "$1" == "-?" ]; then
	echo "USAGE: $0 -p [Log pattern to retrieve] -l (Lists jboss log dir) -? (This usage)"
	exit
 fi
done
echo "Log pattern to retrieve: [$LP]"
    for sn in `cat tdpserver.lst`
	do
	echo "--------------------------  $sn -------------------------------"
	#ssh root@$sn "ls -al $TL/*.log*"
	#scp root@$sn:$TL/matrixtdp.log.[5678] .
	rm -rf tdplogs.$sn
	mkdir tdplogs.$sn
	scp root@$sn:$TL/$LP tdplogs.$sn
	done
    zip QA.logs.$dt.zip tdplogs.*/*
    ftp $dlxftp
	
