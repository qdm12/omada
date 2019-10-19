#!/bin/sh

printf "\n =========================================\n"
printf " =========================================\n"
printf " ===== Omada controller Docker image =====\n"
printf " =========================================\n"
printf " =========================================\n"
printf " == by github.com/qdm12 - Quentin McGaw ==\n\n"

printf "Setting up data directory..."
mkdir -p data/db data/map data/portal
printf "DONE\n"
printf "Setting HTTP port to $HTTPPORT..."
sed -i "/http.connector.port=/c\http.connector.port=$HTTPPORT" properties/jetty.properties
printf "DONE\n"
printf "Setting HTTPS port to $HTTPSPORT..."
sed -i "/https.connector.port=/c\https.connector.port=$HTTPSPORT" properties/jetty.properties
printf "DONE\n"
jre/bin/java -server -Xms128m -Xmx1024m \
    -XX:MaxHeapFreeRatio=60 -XX:MinHeapFreeRatio=30 \
    -XX:+HeapDumpOnOutOfMemoryError -Deap.home=/omada \
    -cp /omada/lib/*: com.tp_link.eap.start.EapLinuxMain
status=$?
printf "\n =========================================\n"
printf " Exit with status $status\n"
printf " =========================================\n"
