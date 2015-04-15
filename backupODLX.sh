#!/bin/bash
# Script to back up all of /opt/datalex

#!/bin/bash
# Copy old deploy.cfg to /tmp just in case

dt=`date +%y%m%d%H%M`

cd /opt

tar cjvf datalex-${dt}.tar.b2z datalex
