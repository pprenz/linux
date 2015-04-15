#!/bin/bash
1.save the certs /tmp/

2. cd /opt/datalex/jdk/bin

3. run ./keytool -import -trustcacerts -keystore /opt/datalex/jdk/jre/lib/security/cacerts -storepass changeit  -noprompt -alias  <usecertfilename> -file /tmp/<certfilename>.crt
