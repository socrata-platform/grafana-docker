# Grafana docker image

This container runs Grafana 2.5.0.

## Composing the Test Environemnt

Run:
  `docker-compose build`

## Running the entire Grafana Environment

Run:
  `docker-compose run grafana -d`

## Building the image individually

Run:
  `docker build --rm -t grafana .`


## Running the image individually

The docker image is configured to set up a graphite datasource
when run.  You must specify at minimum a graphite host.

Run:
  `docker run -i -p 3000:3000 -e "GRAPHITE_HOST=<graphite_host>" grafana`


To run the image with custom settings, you'll likely want to consult
http://docs.grafana.org/installation/configuration/. In particular
note that all configuration going into the ini files can be overriden
using environment variables.

For example, to use a postgres database,

Run:

  ```
  echo 'GRAPHITE_HOST=<graphite_host>' >> envfile
  echo 'GF_DATABASE_TYPE=postgres' > envfile
  echo 'GF_DATABASE_HOST=<pg_host>' > envfile
  echo 'GF_DATABASE_USER=<pg_user>' > envfile
  echo 'GF_DATABASE_PASSWORD=<pg_pass>' > envfile
  docker run --env-file=envfile -p 3000:3000 -d grafana
  ```
