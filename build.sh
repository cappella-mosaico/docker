#!/bin/bash

cd ../pastorais
sed -i 's/localhost\//db\//g' src/main/resources/META-INF/persistence.xml
sed -i 's/localhost\//db\//g' src/main/java/startup/Startup.java
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 && mvn clean install
sed -i 's/db\//localhost\//g' src/main/resources/META-INF/persistence.xml
sed -i 's/db\//localhost\//g' src/main/java/startup/Startup.java
cp ./target/pastorais-1.0-SNAPSHOT.war .
docker build -f Dockerfile -t pastorais .
rm ./pastorais-1.0-SNAPSHOT.war
#cd ../docker || exit

cd ../comunicacao
sed -i 's/localhost:29092/kafka:9092/g' src/main/java/startup/App.java
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 && mvn clean install
sed -i 's/kafka:9092/localhost:29092/g' src/main/java/startup/App.java
cp ./target/comunicacao-1.0-SNAPSHOT.jar .
docker build -f Dockerfile -t comunicacao .
rm ./comunicacao-1.0-SNAPSHOT.jar
