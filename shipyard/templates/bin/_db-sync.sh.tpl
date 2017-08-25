#!/bin/bash

set -ex
export HOME=/tmp

pgsql_shipyard_user_cmd () {
  DB_COMMAND="$1"

  psql \
  -h ${DB_FQDN} \
  -p ${DB_PORT} \
  -U ${DB_USER} \
  --command="${DB_COMMAND}"
}

# TODO: We will add 'create table' commands during db-sync
# when we finalize on the design.  We will make use of the
# 'pgsql_shipyard_user_cmd' function to do that
# It will probably look like the following
#
# Create tables
#
#pgsql_shipyard_user_cmd "CREATE TABLE SHIPYARD(
#ID INT PRIMARY KEY           NOT NULL,
#USER_ID             CHAR(50) NOT NULL,
#TASK_EXECUTED       CHAR(50) NOT NULL,
#TIME_OF_EXECUTION   CHAR(50) NOT NULL
#);"
