#!/bin/bash

# FRONTEND
cd ../front-admin
npm install

# PASTORAIS
cd ../pastorais
sed -i 's/localhost\//db\//g' src/main/resources/META-INF/persistence.xml
sed -i 's/localhost\//db\//g' src/main/java/startup/Startup.java
mvn clean install
sed -i 's/db\//localhost\//g' src/main/resources/META-INF/persistence.xml
sed -i 's/db\//localhost\//g' src/main/java/startup/Startup.java
cp ./target/pastorais-1.0-SNAPSHOT.war .
docker build -f Dockerfile -t pastorais .
rm ./pastorais-1.0-SNAPSHOT.war

# FINANCEIRO
cd ../financeiro
sed -i 's/localhost\//db-financeiro\//g' src/main/resources/META-INF/persistence.xml
sed -i 's/localhost\//db-financeiro\//g' src/main/java/startup/Startup.java
mvn clean install
sed -i 's/db-financeiro\//localhost\//g' src/main/resources/META-INF/persistence.xml
sed -i 's/db-financeiro\//localhost\//g' src/main/java/startup/Startup.java
cp ./target/financeiro-1.0-SNAPSHOT.war .
docker build -f Dockerfile -t financeiro .

# COMUNICACAO
cd ../comunicacao
sed -i 's/localhost:29092/kafka:9092/g' src/main/java/startup/App.java
export ONE_SIGNAL_APP_ID="97bc067c-2344-4a86-a6b1-0206f51df4e9" && export ONE_SIGNAL_APP_KEY="NTgwOTNjYmEtNGZjYi00ZGYyLThmMTktMGM5MzdiNzRkZDkz" && mvn clean install
sed -i 's/kafka:9092/localhost:29092/g' src/main/java/startup/App.java
cp ./target/comunicacao-1.0-SNAPSHOT.jar .
docker build -f Dockerfile -t comunicacao .
rm ./comunicacao-1.0-SNAPSHOT.jar
