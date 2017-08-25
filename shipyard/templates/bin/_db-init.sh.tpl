#!/bin/bash

set -ex
export HOME=/tmp

pgsql_superuser_cmd () {
  DB_COMMAND="$1"
  if [[ ! -z $2 ]]; then
      EXPORT PGDATABASE=$2
  fi

  psql \
  -h ${DB_FQDN} \
  -p ${DB_PORT} \
  -U ${ROOT_DB_USER} \
  --command="${DB_COMMAND}"
}

pgsql_superuser_cmd () {
  DB_COMMAND="$1"

  psql \
  -h ${DB_FQDN} \
  -p ${DB_PORT} \
  -U ${ROOT_DB_USER} \
  --command="${DB_COMMAND}"
}

# Create db
pgsql_superuser_cmd "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -q 1 || pgsql_superuser_cmd "CREATE DATABASE $DB_NAME"

# Create db user
pgsql_superuser_cmd "SELECT * FROM pg_roles WHERE rolname = '$DB_USER';" | tail -n +3 | head -n -2 | grep -q 1 || \
    pgsql_superuser_cmd "CREATE ROLE ${DB_USER} LOGIN PASSWORD '$DB_PASS';" && pgsql_superuser_cmd "ALTER USER ${DB_USER} WITH SUPERUSER"

# Grant permissions to user
pgsql_superuser_cmd "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME to $DB_USER;"

# Grant permissions to shipyard user for it to connect to airflow database
# This will allow shipyard user to query airflow database
pgsql_superuser_cmd "GRANT CONNECT ON DATABASE airflow to $DB_USER;"
