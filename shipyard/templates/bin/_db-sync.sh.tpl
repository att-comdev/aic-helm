#!/bin/bash

set -ex
export HOME=/tmp

# Extract the DB string from shipyard.conf and get the
# value of the DB host and port
db_string=`grep -i postgresql_db ${SHIPYARD_CONFIG_FILE}`
db_fqdn=`echo ${db_string#*@} | cut -f1 -d"."`
db_port=`echo ${db_string#*@} | grep -o "[0-9]\+"`

pgsql_shipyard_user_cmd () {
  DB_COMMAND="$1"

  psql \
  -h $db_fqdn \
  -p $db_port \
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
