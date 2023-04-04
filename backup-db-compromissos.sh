#!/bin/sh

SERVICE_CONTAINER=$(docker ps -qf "name=docker_db-compromissos")
SERVICE_NAME="compromissos"
docker exec -it ${SERVICE_CONTAINER} bash -c 'pg_dump --user postgres compromissos > "$(date +'%Y-%m-%d_%H:%M')-backup.sql" && mv *.sql /tmp && tar czf backup.tar.gz tmp' && docker cp ${SERVICE_CONTAINER}:backup.tar.gz ./"$(date +'%Y-%m-%d_%H%M')-backups-${SERVICE_NAME}.tar.gz"
