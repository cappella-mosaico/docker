# Running process

Before starting, make sure you have Docker, docker-compose and Docker Desktop installed - https://docs.docker.com/get-docker/

- Clone all repos from the organization
  - git clone git@github.com:cappella-mosaico/front-admin.git
  - git clone git@github.com:cappella-mosaico/pastorais.git
  - git clone git@github.com:cappella-mosaico/financeiro.git
  - git clone git@github.com:cappella-mosaico/comunicacao.git
- Back to docker (cd ..)
  - `./linux_build.sh` or `./mac_build.sh` based on your environment
  - `docker-compose up`
