#!/bin/bash
APP="TDP"
>tdpserver.lst
UI="CUI MUI RST"
>uiserver.lst
DB="MCH MDB"
>dbserver.lst

echo "Creating the tdpserver.lst"
for st in $APP
do
echo $st
  grep "^$st=" ../deploy.cfg | while read ae
	do	
        echo $ae | cut -f2 -d'"' >> tdpserver.lst
	done
done

echo "Creating the uiserver.lst"
for st in $UI
do
  echo $st
  grep "^$st=" ../deploy.cfg | while read ae
	do	
        echo $ae | cut -f2 -d'"' >> uiserver.lst
	done
done

echo "Creating the dbserver.lst"
for st in $DB
do
  echo $st
  grep -E "^$st[A-Z]=|^$st=" ../deploy.cfg | while read ae
	do	
        echo $ae | cut -f2 -d'"' >> dbserver.lst
	done
done
