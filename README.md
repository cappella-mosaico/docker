# this repo
this repo's goal is to be the starting point for the rest of the project. By using its scripts you should be able to pull, build and start the services. A brief description of each service can be found inside their own READMEs.

# prepare yourself

Before starting, make sure you have `docker`, `docker-compose` and Docker Desktop installed - https://docs.docker.com/get-docker/
you'll also need `Java`, `Maven`, `node`, `NPM` and `postgresql`.

To install Java and Maven, first install SDKMAN with `curl -s "https://get.sdkman.io" | bash`
then `sdk install java 19.0.2-open`
then `sdk install maven`

To install node and NPM, first install Volta with `curl https://get.volta.sh | bash`
then `volta install node`

To install postgres: `sudo apt install postgresql`

# create the test databases

Some of our services have integration tests that rely on databases available by the postgres on the host machine. After installing postgres you should login and create these test databases. They should be empty as migrations will be executed once they are there.

```
To log in without a password:
  sudo -u user_name psql db_name

To reset the password if you have forgotten:
  ALTER USER postgres WITH PASSWORD 'new_password';
```

#### login to postgres
`psql -U postgres --password`

#### once inside postgres' shell, create the databases
`create database test-compromissos;`
`create database test-eventos;`
`\q`

# build and run

- Clone all repos from the organization
  - `pull_services.sh`
- Build the application by running the build script
  - `./build.sh`
- Start the application
  - `docker-compose up`

if everything goes well, you'll be able to access it by going to http://localhost
