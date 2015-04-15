#!/bin/bash
CAT=/bin/cat
DLP="/opt/datalex/TDP_CURRENT/totality/deploy.cfg"

echo Content-type: text/plain
echo ""

if [[ -x $CAT && -f $DLP ]]
then
        $CAT $DLP
else
        echo Cannot find command on this system.
fi
