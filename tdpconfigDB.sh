#!/bin/bash
. ../deploy.cfg
cd ${ODL}/${DLX}/tools/install
echo "Running and piping Y to tdpConfig.sh -configureDatabase...."
yes | tr 'y' 'Y' | ./tdpConfig.sh -configureDatabase
