#!/bin/bash

docker-compose stop
./build.sh
docker-compose up -d
