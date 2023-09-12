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

# create a certs directory
`mkdir ~/certs`
create an www.ipmosaico.com.pem and an www.ipmosaico.com.key files inside that directory

Feel free to copy my www.ipmosaico.com.key:

```
-----BEGIN PRIVATE KEY-----
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
b6J0WtmCxrHRNH+mNuimB7yMUOfuibM=
-----END PRIVATE KEY-----
```

and my www.ipmosaico.com.pem

```
-----BEGIN TRUSTED CERTIFICATE-----
MIIFRzCCAy8CFEUzCidKLpGSggpEtXwTHViVcZ7DMA0GCSqGSIb3DQEBCwUAMGAx
CzAJBgNVBAYTAkJSMQ4wDAYDVQQIDAVHb2lhczEQMA4GA1UEBwwHR29pYW5pYTEO
MAwGA1UECgwFRGV2b3UxHzAdBgkqhkiG9w0BCQEWEGRlbGtpOEBnbWFpbC5jb20w
HhcNMjMwMjI4MTI1MjIyWhcNMjQwMjI4MTI1MjIyWjBgMQswCQYDVQQGEwJCUjEO
MAwGA1UECAwFR29pYXMxEDAOBgNVBAcMB0dvaWFuaWExDjAMBgNVBAoMBURldm91
MR8wHQYJKoZIhvcNAQkBFhBkZWxraThAZ21haWwuY29tMIICIjANBgkqhkiG9w0B
AQEFAAOCAg8AMIICCgKCAgEArk1opb3oeV5mY6C79IDQQ54AQDvfcX9jUkKUsg4/
uD9QGBAAPBam8IbpJmjDho4H17AfkyULTHLeVOLwCzIl29Kb3bKg8ZTI5aNJXTwu
P6holTOGONwoRDzgGC/Bi+o0pblZZ1eExWuG4ocOZmjTdR+Yw+Kv9JJdNEhRWUX0
N/I9jeHL5Bsea3c9df82s7llabfXnY57QcrbpMeNyECiAFPHsPdrpucwiDeBxSVr
xb9yERlYFj8MqVZXOSsAxQjQdAhHEAF/WBfLDLDqO1Es5TObUBnoI4xR3sgI9hJ2
MwIR4YN8psTbO/g6ZLxTztq/AlKg5bG5S0x3ymRF+rcVSk9rfNmkVEMTmKHMrqkE
+n+JXpW5EM/BqabShQgfZ9uTogGIgr5fMcZAk3r99rbRAmRUg+8D36pHaXCr4QHT
ImaNq4GhShOyY8/BW2Jofv52iUFQvVhu3fL/G1GL8ZTg53AYzdC2ooyiGpjdEi3D
rjfOVpRpxtIK8+Jy4viWD7XKOhc+vhDuq9qx4DFPZD5DDZ8Tb0pRP02Hd5TZw+Qw
L4uboPVj3wnyYMk712mrWgDUxESEr6M26e+nBf0KzcgC8FkYL6FWPs5FD2qxqrpi
OPIHeNTTyFlrYh8bnu8M4X37NL0j4vRLGpzY9FuP1gQjmqvdTYcsAoJBZFITWKpj
N2MCAwEAATANBgkqhkiG9w0BAQsFAAOCAgEAcFsv1xF9u3L3DaOLrg5idByRU2sX
FtLlMxdkiDJ9Zkoiyxg/D+6jQkf7vMwe8ZWd0UH/Ilt2VBZVCax7Tek6m5wb+WTV
/KhFJPRvN2sfJbqCcFftbTc2YOwq16Z36EK/ZHh4/MlL9KJHddWVRd2MqeByPp9T
50q6uKxNJW5MU9szM0sLKWZM6ZMrqB4tLQ+PgGBaK9c45HezeetyzqqbUjkjY8MA
HGRknFh12iyDbnLw1oXlvVqC8EtU+JsUFK/A9b8n6WoF5IQrd6ehyEmIkQDRBElS
JaVGIgUjSnOnU8VVkpTL/NpPm0NTO4qS9t/4B9CP2cAXSSgwNRcyM400hJ71nkRV
MIUzL1b1xR0X/2nBOI05czTdFaiWn7YXcXTXWzITtwHVPa3Orzz7YL5WRKJKnMol
d6Obl3eDtCvXysyhOWYAk+fs/dmCjGwRQhDv8d9WI5oDHF1h62UabNbjda8NH1lx
pJHpRAfUogfm9BBRKg20PXVKpuablf055OwM75VSkZnLoEdu5FYrekfucDkLOCa8
YsM05kwbFtK5GKNmQsJghDP3eYiPwwVsQJaHQIwxH0jyzkrXlIOowenRoRfGblCm
tOYkT9rhS1zA5wWuegeh0HL0uYnhOVb2sbnSiggcmcTjs4j9Vwkxum/mq1udPNfJ
ejYtaYprUAsiU+w=
-----END TRUSTED CERTIFICATE-----
```

# build and run

- Clone all repos from the organization
- `pull_services.sh`
- Build the application by running the build script
- `./build.sh`
- Start the application
- `docker-compose up`

# check running containers
`docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Image}}"`

if everything goes well, you'll be able to access it by going to http://localhost
