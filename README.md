# Running process

Before starting, make sure you have Docker, docker-compose and Docker Desktop installed - https://docs.docker.com/get-docker/

- Clone all repos from the organization
  - git clone git@github.com:cappella-mosaico/front-admin.git
  - git clone git@github.com:cappella-mosaico/pastorais.git
  - git clone git@github.com:cappella-mosaico/financeiro.git
  - git clone git@github.com:cappella-mosaico/comunicacao.git
- cd front-admin -> npm install
- Back to docker (cd ..)
  - ./build.sh
  - docker-compose up    
