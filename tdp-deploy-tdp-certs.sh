#!/bin/bash
. ../deploy.cfg

./mklists.sh

for SVR in `cat tdpserver.lst`
do
echo "Copying certs to server [$SVR]...."
su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$SVR \"mkdir ${ODL}/JBcerts\""
su - $JBU -c "scp ${ODL}/${DLX}/JBcerts/*.cer root@$SVR:${ODL}/JBcerts"
echo "Running import_JBcerts.sh..."
su - $JBU -c "ssh -oStrictHostKeyChecking=no root@$SVR 'bash -s' < ${ODL}/${DLX}/totality/scripts/import-JBcerts.sh"
done

