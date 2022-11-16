# this repo
this repo's goal is to be the starting point for the rest of the project. By using its scripts you should be able to pull, build and start the services. A brief description of each service can be found inside their own READMEs.

# prepare yourself

Before starting, make sure you have `docker`, `docker-compose` and Docker Desktop installed - https://docs.docker.com/get-docker/
you'll also need `Java`, `Maven`, `Node` and `NPM`.

To install Java and Maven, first install SDKMAN with `curl -s "https://get.sdkman.io" | bash`
then `sdk install java 17.0.2-open`
then `sdk install maven`

# build and run

- Clone all repos from the organization
  - `pull_services.sh`
- Build the application by running the build script based on your environment
  - `./linux_build.sh` or `./mac_build.sh`
- Start the application
  - `docker-compose up`

if everything goes well, you'll be able to access it by going to http://localhost:3001
