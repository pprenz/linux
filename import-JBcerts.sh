## Import the JB chain certs
cd /opt/datalex/jdk/bin

# Certs should already exist and have been copied to the /opt/datalex/JBcerts dir
#for i in RootCAChain2034.cer SubEnt12034.cer SubEnt2_2034.cer

for i in `ls /opt/datalex/JBcerts/*.cer`
do
echo "Importing cert [$i] into java keystore..."
./keytool -import -trustcacerts -keystore /opt/datalex/jdk/jre/lib/security/cacerts -storepass changeit  -noprompt -alias `basename $i` -file $i
done

