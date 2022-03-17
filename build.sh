#!/bin/bash

cd ../pastorais
sed -i 's/localhost\//db\//g' src/main/resources/META-INF/persistence.xml
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 && mvn clean install
sed -i 's/db\//localhost\//g' src/main/resources/META-INF/persistence.xml
cd ../docker || exit
cp ../pastorais/target/pastorais-1.0-SNAPSHOT.war .
docker build -f ./Dockerfile -t pastorais .
rm ./pastorais-1.0-SNAPSHOT.war
