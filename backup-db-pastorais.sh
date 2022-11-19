SERVICE_NAME="pastorais"
docker exec -it $1 bash -c 'pg_dump --user postgres pastorais > "$(date +'%Y-%m-%d_%H:%M')-backup.sql" && mv *.sql /tmp && tar czf backup.tar.gz tmp' && docker cp $1:backup.tar.gz ./"$(date +'%Y-%m-%d_%H%M')-backups-${SERVICE_NAME}.tar.gz"
