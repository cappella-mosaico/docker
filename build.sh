#!/bin/bash

function replace() {
  local regex=$1
  local file_to_change=$2
  if [[ "$OSTYPE" == "linux"* ]]; then
    sed -i $regex $file_to_change
  else
    sed -i '' $regex $file_to_change
  fi
}

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


# REVERSEPROXY
echo ' ______    _______  __   __  _______  ______    _______  _______  _______  ______    _______  __   __  __   __ '
echo '|    _ |  |       ||  | |  ||       ||    _ |  |       ||       ||       ||    _ |  |       ||  |_|  ||  | |  |'
echo '|   | ||  |    ___||  |_|  ||    ___||   | ||  |  _____||    ___||    _  ||   | ||  |   _   ||       ||  |_|  |'
echo '|   |_||_ |   |___ |       ||   |___ |   |_||_ | |_____ |   |___ |   |_| ||   |_||_ |  | |  ||       ||       |'
echo '|    __  ||    ___||       ||    ___||    __  ||_____  ||    ___||    ___||    __  ||  |_|  | |     | |_     _|'
echo '|   |  | ||   |___  |     | |   |___ |   |  | | _____| ||   |___ |   |    |   |  | ||       ||   _   |  |   |  '
echo '|___|  |_||_______|  |___|  |_______||___|  |_||_______||_______||___|    |___|  |_||_______||__| |__|  |___|  '

cd ../reverseproxy
docker build --quiet -t reverseproxy .

# EVENTOS
echo ' _______  __   __  _______  __    _  _______  _______  _______ '
echo '|       ||  | |  ||       ||  |  | ||       ||       ||       |'
echo '|    ___||  |_|  ||    ___||   |_| ||_     _||   _   ||  _____|'
echo '|   |___ |       ||   |___ |       |  |   |  |  | |  || |_____ '
echo '|    ___||       ||    ___||  _    |  |   |  |  |_|  ||_____  |'
echo '|   |___  |     | |   |___ | | |   |  |   |  |       | _____| |'
echo '|_______|  |___|  |_______||_|  |__|  |___|  |_______||_______|'

cd ../eventos
replace 's/localhost:5432/db-eventos/g' src/main/resources/application.properties
./mvnw install -q
cp ./target/eventos-0.0.1-SNAPSHOT.jar .
docker build --quiet -f Dockerfile -t eventos .
rm ./eventos-0.0.1-SNAPSHOT.jar
replace 's/db-eventos/localhost:5432/g' src/main/resources/application.properties

# COMPROMISSOS
echo ' _______  _______  __   __  _______  ______    _______  __   __  ___   _______  _______  _______  _______ '
echo '|       ||       ||  |_|  ||       ||    _ |  |       ||  |_|  ||   | |       ||       ||       ||       |'
echo '|       ||   _   ||       ||    _  ||   | ||  |   _   ||       ||   | |  _____||  _____||   _   ||  _____|'
echo '|       ||  | |  ||       ||   |_| ||   |_||_ |  | |  ||       ||   | | |_____ | |_____ |  | |  || |_____ '
echo '|      _||  |_|  ||       ||    ___||    __  ||  |_|  ||       ||   | |_____  ||_____  ||  |_|  ||_____  |'
echo '|     |_ |       || ||_|| ||   |    |   |  | ||       || ||_|| ||   |  _____| | _____| ||       | _____| |'
echo '|_______||_______||_|   |_||___|    |___|  |_||_______||_|   |_||___| |_______||_______||_______||_______|'

cd ../compromissos
replace 's/localhost:5432/db-compromissos/g' src/main/resources/application.properties
./mvnw install -q
cp ./target/compromissos-0.0.1-SNAPSHOT.jar .
docker build --quiet -f Dockerfile -t compromissos .
rm ./compromissos-0.0.1-SNAPSHOT.jar
replace 's/db-compromissos/localhost:5432/g' src/main/resources/application.properties

# GATEWAY
echo ' _______  _______  _______  _______  _     _  _______  __   __ '
echo '|       ||   _   ||       ||       || | _ | ||   _   ||  | |  |'
echo '|    ___||  |_|  ||_     _||    ___|| || || ||  |_|  ||  |_|  |'
echo '|   | __ |       |  |   |  |   |___ |       ||       ||       |'
echo '|   ||  ||       |  |   |  |    ___||       ||       ||_     _|'
echo '|   |_| ||   _   |  |   |  |   |___ |   _   ||   _   |  |   |  '
echo '|_______||__| |__|  |___|  |_______||__| |__||__| |__|  |___|  '

cd ../gateway
gradle shadowJar --no-daemon --stacktrace
docker build -t gateway .
