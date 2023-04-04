#!/bin/bash

echo 'dont forget to pass .prod as a param when building for production'

# FRONTEND
echo ' _______  ______    _______  __    _  _______  _______  __    _  ______  '
echo '|       ||    _ |  |       ||  |  | ||       ||       ||  |  | ||      | '
echo '|    ___||   | ||  |   _   ||   |_| ||_     _||    ___||   |_| ||  _    |'
echo '|   |___ |   |_||_ |  | |  ||       |  |   |  |   |___ |       || | |   |'
echo '|    ___||    __  ||  |_|  ||  _    |  |   |  |    ___||  _    || |_|   |'
echo '|   |    |   |  | ||       || | |   |  |   |  |   |___ | | |   ||       |'
echo '|___|    |___|  |_||_______||_|  |__|  |___|  |_______||_|  |__||______| '

cd ../front-admin
npm install
docker build --quiet --build-arg REACT_APP_IPMOSAICO_ROOT_URL=$REACT_APP_IPMOSAICO_ROOT_URL -f Dockerfile.prod -t front-admin-prod .

# PASTORAIS

echo ' _______  _______  _______  _______  _______  ______    _______  ___   _______ '
echo '|       ||   _   ||       ||       ||       ||    _ |  |   _   ||   | |       |'
echo '|    _  ||  |_|  ||  _____||_     _||   _   ||   | ||  |  |_|  ||   | |  _____|'
echo '|   |_| ||       || |_____   |   |  |  | |  ||   |_||_ |       ||   | | |_____ '
echo '|    ___||       ||_____  |  |   |  |  |_|  ||    __  ||       ||   | |_____  |'
echo '|   |    |   _   | _____| |  |   |  |       ||   |  | ||   _   ||   |  _____| |'
echo '|___|    |__| |__||_______|  |___|  |_______||___|  |_||__| |__||___| |_______|'

cd ../docker
cp ./tomcat/conf/web.xml$1 ../pastorais/web.xml
cp ./tomcat/*.jar ../pastorais/
cd ../pastorais
sed -i 's/localhost\//db-pastorais\//g' src/main/resources/META-INF/persistence.xml
sed -i 's/localhost\//db-pastorais\//g' src/main/java/startup/Startup.java
mvn --quiet clean install
sed -i 's/db-pastorais\//localhost\//g' src/main/resources/META-INF/persistence.xml
sed -i 's/db-pastorais\//localhost\//g' src/main/java/startup/Startup.java
cp ./target/pastorais-1.0-SNAPSHOT.war .
docker build --quiet -f Dockerfile -t pastorais .
rm ./pastorais-1.0-SNAPSHOT.war
rm ./web.xml
rm ./*.jar

# FINANCEIRO
echo ' _______  ___   __    _  _______  __    _  _______  _______  ___   ______    _______ '
echo '|       ||   | |  |  | ||   _   ||  |  | ||       ||       ||   | |    _ |  |       |'
echo '|    ___||   | |   |_| ||  |_|  ||   |_| ||       ||    ___||   | |   | ||  |   _   |'
echo '|   |___ |   | |       ||       ||       ||       ||   |___ |   | |   |_||_ |  | |  |'
echo '|    ___||   | |  _    ||       ||  _    ||      _||    ___||   | |    __  ||  |_|  |'
echo '|   |    |   | | | |   ||   _   || | |   ||     |_ |   |___ |   | |   |  | ||       |'
echo '|___|    |___| |_|  |__||__| |__||_|  |__||_______||_______||___| |___|  |_||_______|'

cd ../docker
cp ./tomcat/conf/web.xml$1 ../financeiro/web.xml
cp ./tomcat/*.jar ../financeiro/
cd ../financeiro
sed -i 's/localhost\//db-financeiro\//g' src/main/resources/META-INF/persistence.xml
sed -i 's/localhost\//db-financeiro\//g' src/main/java/startup/Startup.java
mvn --quiet clean install
sed -i 's/db-financeiro\//localhost\//g' src/main/resources/META-INF/persistence.xml
sed -i 's/db-financeiro\//localhost\//g' src/main/java/startup/Startup.java
cp ./target/financeiro-1.0-SNAPSHOT.war .
docker build --quiet -f Dockerfile -t financeiro .
rm ./financeiro-1.0-SNAPSHOT.war
rm ./web.xml
rm ./*.jar

# COMUNICACAO
echo ' _______  _______  __   __  __   __  __    _  ___   _______  _______  _______  _______  _______ '
echo '|       ||       ||  |_|  ||  | |  ||  |  | ||   | |       ||   _   ||       ||   _   ||       |'
echo '|       ||   _   ||       ||  | |  ||   |_| ||   | |       ||  |_|  ||       ||  |_|  ||   _   |'
echo '|       ||  | |  ||       ||  |_|  ||       ||   | |       ||       ||       ||       ||  | |  |'
echo '|      _||  |_|  ||       ||       ||  _    ||   | |      _||       ||      _||       ||  |_|  |'
echo '|     |_ |       || ||_|| ||       || | |   ||   | |     |_ |   _   ||     |_ |   _   ||       |'
echo '|_______||_______||_|   |_||_______||_|  |__||___| |_______||__| |__||_______||__| |__||_______|'

cd ../comunicacao
sed -i 's/localhost:29092/kafka:9092/g' src/main/java/kafka/NewPastoralConsumer.java
sed -i 's/localhost:29092/kafka:9092/g' src/main/java/kafka/LembretePastoralConsumer.java
sed -i 's/localhost:29092/kafka:9092/g' src/main/java/kafka/NewRelatorioFinanceiroConsumer.java
export ONE_SIGNAL_APP_ID="97bc067c-2344-4a86-a6b1-0206f51df4e9" && export ONE_SIGNAL_APP_KEY="NTgwOTNjYmEtNGZjYi00ZGYyLThmMTktMGM5MzdiNzRkZDkz" && mvn --quiet clean install
sed -i 's/kafka:9092/localhost:29092/g' src/main/java/kafka/NewPastoralConsumer.java
sed -i 's/kafka:9092/localhost:29092/g' src/main/java/kafka/LembretePastoralConsumer.java
sed -i 's/kafka:9092/localhost:29092/g' src/main/java/kafka/NewRelatorioFinanceiroConsumer.java
cp ./target/comunicacao-1.0-SNAPSHOT.jar .
docker build --quiet -f Dockerfile -t comunicacao .
rm ./comunicacao-1.0-SNAPSHOT.jar

# EVENTOS
echo ' _______  __   __  _______  __    _  _______  _______  _______ '
echo '|       ||  | |  ||       ||  |  | ||       ||       ||       |'
echo '|    ___||  |_|  ||    ___||   |_| ||_     _||   _   ||  _____|'
echo '|   |___ |       ||   |___ |       |  |   |  |  | |  || |_____ '
echo '|    ___||       ||    ___||  _    |  |   |  |  |_|  ||_____  |'
echo '|   |___  |     | |   |___ | | |   |  |   |  |       | _____| |'
echo '|_______|  |___|  |_______||_|  |__|  |___|  |_______||_______|'

cd ../eventos
sed -i 's/localhost:5432/db-eventos/g' src/main/resources/application.properties
./mvnw install -q
cp ./target/eventos-0.0.1-SNAPSHOT.jar .
docker build --quiet -f Dockerfile -t eventos .
rm ./eventos-0.0.1-SNAPSHOT.jar
sed -i 's/db-eventos/localhost:5432/g' src/main/resources/application.properties

# COMPROMISSOS
echo ' _______  _______  __   __  _______  ______    _______  __   __  ___   _______  _______  _______  _______ '
echo '|       ||       ||  |_|  ||       ||    _ |  |       ||  |_|  ||   | |       ||       ||       ||       |'
echo '|       ||   _   ||       ||    _  ||   | ||  |   _   ||       ||   | |  _____||  _____||   _   ||  _____|'
echo '|       ||  | |  ||       ||   |_| ||   |_||_ |  | |  ||       ||   | | |_____ | |_____ |  | |  || |_____ '
echo '|      _||  |_|  ||       ||    ___||    __  ||  |_|  ||       ||   | |_____  ||_____  ||  |_|  ||_____  |'
echo '|     |_ |       || ||_|| ||   |    |   |  | ||       || ||_|| ||   |  _____| | _____| ||       | _____| |'
echo '|_______||_______||_|   |_||___|    |___|  |_||_______||_|   |_||___| |_______||_______||_______||_______|'

cd ../compromissos
sed -i 's/localhost:5432/db-compromissos/g' src/main/resources/application.properties
./mvnw install -q
cp ./target/compromissos-0.0.1-SNAPSHOT.jar .
docker build --quiet -f Dockerfile -t compromissos .
rm ./compromissos-0.0.1-SNAPSHOT.jar
sed -i 's/db-compromissos/localhost:5432/g' src/main/resources/application.properties

# GATEWAY
echo ' _______  _______  _______  _______  _     _  _______  __   __ '
echo '|       ||   _   ||       ||       || | _ | ||   _   ||  | |  |'
echo '|    ___||  |_|  ||_     _||    ___|| || || ||  |_|  ||  |_|  |'
echo '|   | __ |       |  |   |  |   |___ |       ||       ||       |'
echo '|   ||  ||       |  |   |  |    ___||       ||       ||_     _|'
echo '|   |_| ||   _   |  |   |  |   |___ |   _   ||   _   |  |   |  '
echo '|_______||__| |__|  |___|  |_______||__| |__||__| |__|  |___|  '

cd ../gateway
docker build --quiet -t gateway .
