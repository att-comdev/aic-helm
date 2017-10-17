# Copyright 2017 The Openstack-Helm Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

{{ include "deckhand.conf.deckhand_values_skeleton" .Values.conf.deckhand | trunc 0 }}
{{ include "deckhand.conf.deckhand" .Values.conf.deckhand }}

{{- define "deckhand.conf.deckhand_values_skeleton" -}}

{{- if not .DEFAULT -}}{{- set . "DEFAULT" dict -}}{{- end -}}
{{- if not .barbican -}}{{- set . "barbican" dict -}}{{- end -}}
{{- if not .cors -}}{{- set . "cors" dict -}}{{- end -}}
{{- if not .database -}}{{- set . "database" dict -}}{{- end -}}
{{- if not .healthcheck -}}{{- set . "healthcheck" dict -}}{{- end -}}
{{- if not .keystone_authtoken -}}{{- set . "keystone_authtoken" dict -}}{{- end -}}
{{- if not .keystone_authtoken.keystonemiddleware -}}{{- set .keystone_authtoken "keystonemiddleware" dict -}}{{- end -}}
{{- if not .keystone_authtoken.keystonemiddleware.auth_token -}}{{- set .keystone_authtoken.keystonemiddleware "auth_token" dict -}}{{- end -}}
{{- if not .keystone_authtoken.processing_engine -}}{{- set .keystone_authtoken "processing_engine" dict -}}{{- end -}}
{{- if not .oslo_middleware -}}{{- set . "oslo_middleware" dict -}}{{- end -}}
{{- if not .oslo_policy -}}{{- set . "oslo_policy" dict -}}{{- end -}}

{{- end -}}


{{- define "deckhand.conf.deckhand" -}}


[DEFAULT]
#
# From deckhand.conf
#

#
# Allow limited access to unauthenticated users.
#
# Assign a boolean to determine API access for unathenticated
# users. When set to False, the API cannot be accessed by
# unauthenticated users. When set to True, unauthenticated users can
# access the API with read-only privileges. This however only applies
# when using ContextMiddleware.
#
# Possible values:
#     * True
#     * False
#  (boolean value)
{{ if not .DEFAULT.allow_anonymous_access }}#{{ end }}allow_anonymous_access = {{ .DEFAULT.allow_anonymous_access | default "false" }}

#
# From oslo.log
#

# If set to true, the logging level will be set to DEBUG instead of the default
# INFO level. (boolean value)
# Note: This option can be changed without restarting.
{{ if not .DEFAULT.debug }}#{{ end }}debug = {{ .DEFAULT.debug | default "false" }}

# The name of a logging configuration file. This file is appended to any
# existing logging configuration files. For details about logging configuration
# files, see the Python logging module documentation. Note that when logging
# configuration files are used then all logging configuration is set in the
# configuration file and other logging configuration options are ignored (for
# example, logging_context_format_string). (string value)
# Note: This option can be changed without restarting.
# Deprecated group/name - [DEFAULT]/log_config
{{ if not .DEFAULT.log_config_append }}#{{ end }}log_config_append = {{ .DEFAULT.log_config_append | default "<None>" }}

# Defines the format string for %%(asctime)s in log records. Default:
# %(default)s . This option is ignored if log_config_append is set. (string
# value)
{{ if not .DEFAULT.log_date_format }}#{{ end }}log_date_format = {{ .DEFAULT.log_date_format | default "%Y-%m-%d %H:%M:%S" }}

# (Optional) Name of log file to send logging output to. If no default is set,
# logging will go to stderr as defined by use_stderr. This option is ignored if
# log_config_append is set. (string value)
# Deprecated group/name - [DEFAULT]/logfile
{{ if not .DEFAULT.log_file }}#{{ end }}log_file = {{ .DEFAULT.log_file | default "<None>" }}

# (Optional) The base directory used for relative log_file  paths. This option
# is ignored if log_config_append is set. (string value)
# Deprecated group/name - [DEFAULT]/logdir
{{ if not .DEFAULT.log_dir }}#{{ end }}log_dir = {{ .DEFAULT.log_dir | default "<None>" }}

# Uses logging handler designed to watch file system. When log file is moved or
# removed this handler will open a new log file with specified path
# instantaneously. It makes sense only if log_file option is specified and Linux
# platform is used. This option is ignored if log_config_append is set. (boolean
# value)
{{ if not .DEFAULT.watch_log_file }}#{{ end }}watch_log_file = {{ .DEFAULT.watch_log_file | default "false" }}

# Use syslog for logging. Existing syslog format is DEPRECATED and will be
# changed later to honor RFC5424. This option is ignored if log_config_append is
# set. (boolean value)
{{ if not .DEFAULT.use_syslog }}#{{ end }}use_syslog = {{ .DEFAULT.use_syslog | default "false" }}

# Enable journald for logging. If running in a systemd environment you may wish
# to enable journal support. Doing so will use the journal native protocol which
# includes structured metadata in addition to log messages.This option is
# ignored if log_config_append is set. (boolean value)
{{ if not .DEFAULT.use_journal }}#{{ end }}use_journal = {{ .DEFAULT.use_journal | default "false" }}

# Syslog facility to receive log lines. This option is ignored if
# log_config_append is set. (string value)
{{ if not .DEFAULT.syslog_log_facility }}#{{ end }}syslog_log_facility = {{ .DEFAULT.syslog_log_facility | default "LOG_USER" }}

# Log output to standard error. This option is ignored if log_config_append is
# set. (boolean value)
{{ if not .DEFAULT.use_stderr }}#{{ end }}use_stderr = {{ .DEFAULT.use_stderr | default "false" }}

# Format string to use for log messages with context. (string value)
{{ if not .DEFAULT.logging_context_format_string }}#{{ end }}logging_context_format_string = {{ .DEFAULT.logging_context_format_string | default "%(asctime)s.%(msecs)03d %(process)d %(levelname)s %(name)s [%(request_id)s %(user_identity)s] %(instance)s%(message)s" }}

# Format string to use for log messages when context is undefined. (string
# value)
{{ if not .DEFAULT.logging_default_format_string }}#{{ end }}logging_default_format_string = {{ .DEFAULT.logging_default_format_string | default "%(asctime)s.%(msecs)03d %(process)d %(levelname)s %(name)s [-] %(instance)s%(message)s" }}

# Additional data to append to log message when logging level for the message is
# DEBUG. (string value)
{{ if not .DEFAULT.logging_debug_format_suffix }}#{{ end }}logging_debug_format_suffix = {{ .DEFAULT.logging_debug_format_suffix | default "%(funcName)s %(pathname)s:%(lineno)d" }}

# Prefix each line of exception output with this format. (string value)
{{ if not .DEFAULT.logging_exception_prefix }}#{{ end }}logging_exception_prefix = {{ .DEFAULT.logging_exception_prefix | default "%(asctime)s.%(msecs)03d %(process)d ERROR %(name)s %(instance)s" }}

# Defines the format string for %(user_identity)s that is used in
# logging_context_format_string. (string value)
{{ if not .DEFAULT.logging_user_identity_format }}#{{ end }}logging_user_identity_format = {{ .DEFAULT.logging_user_identity_format | default "%(user)s %(tenant)s %(domain)s %(user_domain)s %(project_domain)s" }}

# List of package logging levels in logger=LEVEL pairs. This option is ignored
# if log_config_append is set. (list value)
{{ if not .DEFAULT.default_log_levels }}#{{ end }}default_log_levels = {{ .DEFAULT.default_log_levels | default "amqp=WARN,amqplib=WARN,boto=WARN,qpid=WARN,sqlalchemy=WARN,suds=INFO,oslo.messaging=INFO,oslo_messaging=INFO,iso8601=WARN,requests.packages.urllib3.connectionpool=WARN,urllib3.connectionpool=WARN,websocket=WARN,requests.packages.urllib3.util.retry=WARN,urllib3.util.retry=WARN,keystonemiddleware=WARN,routes.middleware=WARN,stevedore=WARN,taskflow=WARN,keystoneauth=WARN,oslo.cache=INFO,dogpile.core.dogpile=INFO" }}

# Enables or disables publication of error events. (boolean value)
{{ if not .DEFAULT.publish_errors }}#{{ end }}publish_errors = {{ .DEFAULT.publish_errors | default "false" }}

# The format for an instance that is passed with the log message. (string value)
{{ if not .DEFAULT.instance_format }}#{{ end }}instance_format = {{ .DEFAULT.instance_format | default "[instance: %(uuid)s] " }}

# The format for an instance UUID that is passed with the log message. (string
# value)
{{ if not .DEFAULT.instance_uuid_format }}#{{ end }}instance_uuid_format = {{ .DEFAULT.instance_uuid_format | default "[instance: %(uuid)s] " }}

# Interval, number of seconds, of log rate limiting. (integer value)
{{ if not .DEFAULT.rate_limit_interval }}#{{ end }}rate_limit_interval = {{ .DEFAULT.rate_limit_interval | default "0" }}

# Maximum number of logged messages per rate_limit_interval. (integer value)
{{ if not .DEFAULT.rate_limit_burst }}#{{ end }}rate_limit_burst = {{ .DEFAULT.rate_limit_burst | default "0" }}

# Log level name used by rate limiting: CRITICAL, ERROR, INFO, WARNING, DEBUG or
# empty string. Logs with level greater or equal to rate_limit_except_level are
# not filtered. An empty string means that all levels are filtered. (string
# value)
{{ if not .DEFAULT.rate_limit_except_level }}#{{ end }}rate_limit_except_level = {{ .DEFAULT.rate_limit_except_level | default "CRITICAL" }}

# Enables or disables fatal status of deprecations. (boolean value)
{{ if not .DEFAULT.fatal_deprecations }}#{{ end }}fatal_deprecations = {{ .DEFAULT.fatal_deprecations | default "false" }}

[barbican]
#
# Barbican options for allowing Deckhand to communicate with Barbican.

#
# From deckhand.conf
#

# URL override for the Barbican API endpoint. (string value)
#api_endpoint = http://barbican.example.org:9311/
{{ if not .barbican.api_endpoint }}#{{ end }}api_endpoint = {{ .barbican.api_endpoint | default "<None>" }}

# PEM encoded Certificate Authority to use when verifying HTTPs connections.
# (string value)
{{ if not .barbican.cafile }}#{{ end }}cafile = {{ .barbican.cafile | default "<None>" }}

# PEM encoded client certificate cert file (string value)
{{ if not .barbican.certfile }}#{{ end }}certfile = {{ .barbican.certfile | default "<None>" }}

# PEM encoded client certificate key file (string value)
{{ if not .barbican.keyfile }}#{{ end }}keyfile = {{ .barbican.keyfile | default "<None>" }}

# Verify HTTPS connections. (boolean value)
{{ if not .barbican.insecure }}#{{ end }}insecure = {{ .barbican.insecure | default "false" }}

# Timeout value for http requests (integer value)
{{ if not .barbican.timeout }}#{{ end }}timeout = {{ .barbican.timeout | default "<None>" }}

# Authentication type to load (string value)
# Deprecated group/name - [barbican]/auth_plugin
{{ if not .barbican.auth_type }}#{{ end }}auth_type = {{ .barbican.auth_type | default "<None>" }}

# Config Section from which to load plugin specific options (string value)
{{ if not .barbican.auth_section }}#{{ end }}auth_section = {{ .barbican.auth_section | default "<None>" }}

# Authentication URL (string value)
{{ if not .barbican.auth_url }}#{{ end }}auth_url = {{ .barbican.auth_url | default "<None>" }}

# Domain ID to scope to (string value)
{{ if not .barbican.domain_id }}#{{ end }}domain_id = {{ .barbican.domain_id | default "<None>" }}

# Domain name to scope to (string value)
{{ if not .barbican.domain_name }}#{{ end }}domain_name = {{ .barbican.domain_name | default "<None>" }}

# Project ID to scope to (string value)
{{ if not .barbican.project_id }}#{{ end }}project_id = {{ .barbican.project_id | default "<None>" }}

# Project name to scope to (string value)
{{ if not .barbican.project_name }}#{{ end }}project_name = {{ .barbican.project_name | default "<None>" }}

# Domain ID containing project (string value)
{{ if not .barbican.project_domain_id }}#{{ end }}project_domain_id = {{ .barbican.project_domain_id | default "<None>" }}

# Domain name containing project (string value)
{{ if not .barbican.project_domain_name }}#{{ end }}project_domain_name = {{ .barbican.project_domain_name | default "<None>" }}

# Trust ID (string value)
{{ if not .barbican.trust_id }}#{{ end }}trust_id = {{ .barbican.trust_id | default "<None>" }}

# User ID (string value)
{{ if not .barbican.user_id }}#{{ end }}user_id = {{ .barbican.user_id | default "<None>" }}

# Username (string value)
# Deprecated group/name - [barbican]/user_name
{{ if not .barbican.username }}#{{ end }}username = {{ .barbican.username | default "<None>" }}

# User's domain id (string value)
{{ if not .barbican.user_domain_id }}#{{ end }}user_domain_id = {{ .barbican.user_domain_id | default "<None>" }}

# User's domain name (string value)
{{ if not .barbican.user_domain_name }}#{{ end }}user_domain_name = {{ .barbican.user_domain_name | default "<None>" }}

# User's password (string value)
{{ if not .barbican.password }}#{{ end }}password = {{ .barbican.password | default "<None>" }}

[cors]

#
# From oslo.middleware
#

# Indicate whether this resource may be shared with the domain received in the
# requests "origin" header. Format: "<protocol>://<host>[:<port>]", no trailing
# slash. Example: https://horizon.example.com (list value)
{{ if not .cors.allowed_origin }}#{{ end }}allowed_origin = {{ .cors.allowed_origin | default "<None>" }}

# Indicate that the actual request can include user credentials (boolean value)
{{ if not .cors.allow_credentials }}#{{ end }}allow_credentials = {{ .cors.allow_credentials | default "true" }}

# Indicate which headers are safe to expose to the API. Defaults to HTTP Simple
# Headers. (list value)
{{ if not .cors.expose_headers }}#{{ end }}expose_headers = {{ .cors.expose_headers | default "<None>" }}

# Maximum cache age of CORS preflight requests. (integer value)
{{ if not .cors.max_age }}#{{ end }}max_age = {{ .cors.max_age | default "3600" }}

# Indicate which methods can be used during the actual request. (list value)
{{ if not .cors.allow_methods }}#{{ end }}allow_methods = {{ .cors.allow_methods | default "OPTIONS,GET,HEAD,POST,PUT,DELETE,TRACE,PATCH" }}

# Indicate which header field names may be used during the actual request. (list
# value)
{{ if not .cors.allow_headers }}#{{ end }}allow_headers = {{ .cors.allow_headers | default "<None>" }}

[database]

#
# From oslo.db
#

# If True, SQLite uses synchronous mode. (boolean value)
{{ if not .database.sqlite_synchronous }}#{{ end }}sqlite_synchronous = {{ .database.sqlite_synchronous | default "true" }}

# The back end to use for the database. (string value)
# Deprecated group/name - [DEFAULT]/db_backend
{{ if not .database.backend }}#{{ end }}backend = {{ .database.backend | default "sqlalchemy" }}

# The SQLAlchemy connection string to use to connect to the database. (string
# value)
# Deprecated group/name - [DEFAULT]/sql_connection
# Deprecated group/name - [DATABASE]/sql_connection
# Deprecated group/name - [sql]/connection
{{ if not .database.connection }}#{{ end }}connection = {{ .database.connection | default "<None>" }}

# The SQLAlchemy connection string to use to connect to the slave database.
# (string value)
{{ if not .database.slave_connection }}#{{ end }}slave_connection = {{ .database.slave_connection | default "<None>" }}

# The SQL mode to be used for MySQL sessions. This option, including the
# default, overrides any server-set SQL mode. To use whatever SQL mode is set by
# the server configuration, set this to no value. Example: mysql_sql_mode=
# (string value)
{{ if not .database.mysql_sql_mode }}#{{ end }}mysql_sql_mode = {{ .database.mysql_sql_mode | default "TRADITIONAL" }}

# If True, transparently enables support for handling MySQL Cluster (NDB).
# (boolean value)
{{ if not .database.mysql_enable_ndb }}#{{ end }}mysql_enable_ndb = {{ .database.mysql_enable_ndb | default "false" }}

# Connections which have been present in the connection pool longer than this
# number of seconds will be replaced with a new one the next time they are
# checked out from the pool. (integer value)
# Deprecated group/name - [DATABASE]/idle_timeout
# Deprecated group/name - [database]/idle_timeout
# Deprecated group/name - [DEFAULT]/sql_idle_timeout
# Deprecated group/name - [DATABASE]/sql_idle_timeout
# Deprecated group/name - [sql]/idle_timeout
{{ if not .database.connection_recycle_time }}#{{ end }}connection_recycle_time = {{ .database.connection_recycle_time | default "3600" }}

# Minimum number of SQL connections to keep open in a pool. (integer value)
# Deprecated group/name - [DEFAULT]/sql_min_pool_size
# Deprecated group/name - [DATABASE]/sql_min_pool_size
{{ if not .database.min_pool_size }}#{{ end }}min_pool_size = {{ .database.min_pool_size | default "1" }}

# Maximum number of SQL connections to keep open in a pool. Setting a value of 0
# indicates no limit. (integer value)
# Deprecated group/name - [DEFAULT]/sql_max_pool_size
# Deprecated group/name - [DATABASE]/sql_max_pool_size
{{ if not .database.max_pool_size }}#{{ end }}max_pool_size = {{ .database.max_pool_size | default "5" }}

# Maximum number of database connection retries during startup. Set to -1 to
# specify an infinite retry count. (integer value)
# Deprecated group/name - [DEFAULT]/sql_max_retries
# Deprecated group/name - [DATABASE]/sql_max_retries
{{ if not .database.max_retries }}#{{ end }}max_retries = {{ .database.max_retries | default "10" }}

# Interval between retries of opening a SQL connection. (integer value)
# Deprecated group/name - [DEFAULT]/sql_retry_interval
# Deprecated group/name - [DATABASE]/reconnect_interval
{{ if not .database.retry_interval }}#{{ end }}retry_interval = {{ .database.retry_interval | default "10" }}

# If set, use this value for max_overflow with SQLAlchemy. (integer value)
# Deprecated group/name - [DEFAULT]/sql_max_overflow
# Deprecated group/name - [DATABASE]/sqlalchemy_max_overflow
{{ if not .database.max_overflow }}#{{ end }}max_overflow = {{ .database.max_overflow | default "50" }}

# Verbosity of SQL debugging information: 0=None, 100=Everything. (integer
# value)
# Minimum value: 0
# Maximum value: 100
# Deprecated group/name - [DEFAULT]/sql_connection_debug
{{ if not .database.connection_debug }}#{{ end }}connection_debug = {{ .database.connection_debug | default "0" }}

# Add Python stack traces to SQL as comment strings. (boolean value)
# Deprecated group/name - [DEFAULT]/sql_connection_trace
{{ if not .database.connection_trace }}#{{ end }}connection_trace = {{ .database.connection_trace | default "false" }}

# If set, use this value for pool_timeout with SQLAlchemy. (integer value)
# Deprecated group/name - [DATABASE]/sqlalchemy_pool_timeout
{{ if not .database.pool_timeout }}#{{ end }}pool_timeout = {{ .database.pool_timeout | default "<None>" }}

# Enable the experimental use of database reconnect on connection lost. (boolean
# value)
{{ if not .database.use_db_reconnect }}#{{ end }}use_db_reconnect = {{ .database.use_db_reconnect | default "false" }}

# Seconds between retries of a database transaction. (integer value)
{{ if not .database.db_retry_interval }}#{{ end }}db_retry_interval = {{ .database.db_retry_interval | default "1" }}

# If True, increases the interval between retries of a database operation up to
# db_max_retry_interval. (boolean value)
{{ if not .database.db_inc_retry_interval }}#{{ end }}db_inc_retry_interval = {{ .database.db_inc_retry_interval | default "true" }}

# If db_inc_retry_interval is set, the maximum seconds between retries of a
# database operation. (integer value)
{{ if not .database.db_max_retry_interval }}#{{ end }}db_max_retry_interval = {{ .database.db_max_retry_interval | default "10" }}

# Maximum retries in case of connection error or deadlock error before error is
# raised. Set to -1 to specify an infinite retry count. (integer value)
{{ if not .database.db_max_retries }}#{{ end }}db_max_retries = {{ .database.db_max_retries | default "20" }}

[healthcheck]

#
# From oslo.middleware
#

# DEPRECATED: The path to respond to healtcheck requests on. (string value)
# This option is deprecated for removal.
# Its value may be silently ignored in the future.
{{ if not .healthcheck.path }}#{{ end }}path = {{ .healthcheck.path | default "/healthcheck" }}

# Show more detailed information as part of the response (boolean value)
{{ if not .healthcheck.detailed }}#{{ end }}detailed = {{ .healthcheck.detailed | default "false" }}

# Additional backends that can perform health checks and report that information
# back as part of a request. (list value)
{{ if not .healthcheck.backends }}#{{ end }}backends = {{ .healthcheck.backends | default "<None>" }}

# Check the presence of a file to determine if an application is running on a
# port. Used by DisableByFileHealthcheck plugin. (string value)
{{ if not .healthcheck.disable_by_file_path }}#{{ end }}disable_by_file_path = {{ .healthcheck.disable_by_file_path | default "<None>" }}

# Check the presence of a file based on a port to determine if an application is
# running on a port. Expects a "port:path" list of strings. Used by
# DisableByFilesPortsHealthcheck plugin. (list value)
{{ if not .healthcheck.disable_by_file_paths }}#{{ end }}disable_by_file_paths = {{ .healthcheck.disable_by_file_paths | default "<None>" }}

[keystone_authtoken]

#
# From keystonemiddleware.auth_token
#

# Complete "public" Identity API endpoint. This endpoint should not be an
# "admin" endpoint, as it should be accessible by all end users. Unauthenticated
# clients are redirected to this endpoint to authenticate. Although this
# endpoint should ideally be unversioned, client support in the wild varies. If
# you're using a versioned v2 endpoint here, then this should *not* be the same
# endpoint the service user utilizes for validating tokens, because normal end
# users may not be able to reach that endpoint. (string value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.auth_uri }}#{{ end }}auth_uri = {{ .keystone_authtoken.keystonemiddleware.auth_token.auth_uri | default "<None>" }}

# API version of the admin Identity API endpoint. (string value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.auth_version }}#{{ end }}auth_version = {{ .keystone_authtoken.keystonemiddleware.auth_token.auth_version | default "<None>" }}

# Do not handle authorization requests within the middleware, but delegate the
# authorization decision to downstream WSGI components. (boolean value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.delay_auth_decision }}#{{ end }}delay_auth_decision = {{ .keystone_authtoken.keystonemiddleware.auth_token.delay_auth_decision | default "false" }}

# Request timeout value for communicating with Identity API server. (integer
# value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.http_connect_timeout }}#{{ end }}http_connect_timeout = {{ .keystone_authtoken.keystonemiddleware.auth_token.http_connect_timeout | default "<None>" }}

# How many times are we trying to reconnect when communicating with Identity API
# Server. (integer value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.http_request_max_retries }}#{{ end }}http_request_max_retries = {{ .keystone_authtoken.keystonemiddleware.auth_token.http_request_max_retries | default "3" }}

# Request environment key where the Swift cache object is stored. When
# auth_token middleware is deployed with a Swift cache, use this option to have
# the middleware share a caching backend with swift. Otherwise, use the
# ``memcached_servers`` option instead. (string value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.cache }}#{{ end }}cache = {{ .keystone_authtoken.keystonemiddleware.auth_token.cache | default "<None>" }}

# Required if identity server requires client certificate (string value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.certfile }}#{{ end }}certfile = {{ .keystone_authtoken.keystonemiddleware.auth_token.certfile | default "<None>" }}

# Required if identity server requires client certificate (string value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.keyfile }}#{{ end }}keyfile = {{ .keystone_authtoken.keystonemiddleware.auth_token.keyfile | default "<None>" }}

# A PEM encoded Certificate Authority to use when verifying HTTPs connections.
# Defaults to system CAs. (string value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.cafile }}#{{ end }}cafile = {{ .keystone_authtoken.keystonemiddleware.auth_token.cafile | default "<None>" }}

# Verify HTTPS connections. (boolean value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.insecure }}#{{ end }}insecure = {{ .keystone_authtoken.keystonemiddleware.auth_token.insecure | default "false" }}

# The region in which the identity server can be found. (string value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.region_name }}#{{ end }}region_name = {{ .keystone_authtoken.keystonemiddleware.auth_token.region_name | default "<None>" }}

# DEPRECATED: Directory used to cache files related to PKI tokens. This option
# has been deprecated in the Ocata release and will be removed in the P release.
# (string value)
# This option is deprecated for removal since Ocata.
# Its value may be silently ignored in the future.
# Reason: PKI token format is no longer supported.
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.signing_dir }}#{{ end }}signing_dir = {{ .keystone_authtoken.keystonemiddleware.auth_token.signing_dir | default "<None>" }}

# Optionally specify a list of memcached server(s) to use for caching. If left
# undefined, tokens will instead be cached in-process. (list value)
# Deprecated group/name - [keystone_authtoken]/memcache_servers
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcached_servers }}#{{ end }}memcached_servers = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcached_servers | default "<None>" }}

# In order to prevent excessive effort spent validating tokens, the middleware
# caches previously-seen tokens for a configurable duration (in seconds). Set to
# -1 to disable caching completely. (integer value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.token_cache_time }}#{{ end }}token_cache_time = {{ .keystone_authtoken.keystonemiddleware.auth_token.token_cache_time | default "300" }}

# DEPRECATED: Determines the frequency at which the list of revoked tokens is
# retrieved from the Identity service (in seconds). A high number of revocation
# events combined with a low cache duration may significantly reduce
# performance. Only valid for PKI tokens. This option has been deprecated in the
# Ocata release and will be removed in the P release. (integer value)
# This option is deprecated for removal since Ocata.
# Its value may be silently ignored in the future.
# Reason: PKI token format is no longer supported.
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.revocation_cache_time }}#{{ end }}revocation_cache_time = {{ .keystone_authtoken.keystonemiddleware.auth_token.revocation_cache_time | default "10" }}

# (Optional) If defined, indicate whether token data should be authenticated or
# authenticated and encrypted. If MAC, token data is authenticated (with HMAC)
# in the cache. If ENCRYPT, token data is encrypted and authenticated in the
# cache. If the value is not one of these options or empty, auth_token will
# raise an exception on initialization. (string value)
# Allowed values: None, MAC, ENCRYPT
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_security_strategy }}#{{ end }}memcache_security_strategy = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_security_strategy | default "None" }}

# (Optional, mandatory if memcache_security_strategy is defined) This string is
# used for key derivation. (string value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_secret_key }}#{{ end }}memcache_secret_key = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_secret_key | default "<None>" }}

# (Optional) Number of seconds memcached server is considered dead before it is
# tried again. (integer value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_dead_retry }}#{{ end }}memcache_pool_dead_retry = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_dead_retry | default "300" }}

# (Optional) Maximum total number of open connections to every memcached server.
# (integer value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_maxsize }}#{{ end }}memcache_pool_maxsize = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_maxsize | default "10" }}

# (Optional) Socket timeout in seconds for communicating with a memcached
# server. (integer value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_socket_timeout }}#{{ end }}memcache_pool_socket_timeout = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_socket_timeout | default "3" }}

# (Optional) Number of seconds a connection to memcached is held unused in the
# pool before it is closed. (integer value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_unused_timeout }}#{{ end }}memcache_pool_unused_timeout = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_unused_timeout | default "60" }}

# (Optional) Number of seconds that an operation will wait to get a memcached
# client connection from the pool. (integer value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_conn_get_timeout }}#{{ end }}memcache_pool_conn_get_timeout = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_conn_get_timeout | default "10" }}

# (Optional) Use the advanced (eventlet safe) memcached client pool. The
# advanced pool will only work under python 2.x. (boolean value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_use_advanced_pool }}#{{ end }}memcache_use_advanced_pool = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_use_advanced_pool | default "false" }}

# (Optional) Indicate whether to set the X-Service-Catalog header. If False,
# middleware will not ask for service catalog on token validation and will not
# set the X-Service-Catalog header. (boolean value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.include_service_catalog }}#{{ end }}include_service_catalog = {{ .keystone_authtoken.keystonemiddleware.auth_token.include_service_catalog | default "true" }}

# Used to control the use and type of token binding. Can be set to: "disabled"
# to not check token binding. "permissive" (default) to validate binding
# information if the bind type is of a form known to the server and ignore it if
# not. "strict" like "permissive" but if the bind type is unknown the token will
# be rejected. "required" any form of token binding is needed to be allowed.
# Finally the name of a binding method that must be present in tokens. (string
# value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.enforce_token_bind }}#{{ end }}enforce_token_bind = {{ .keystone_authtoken.keystonemiddleware.auth_token.enforce_token_bind | default "permissive" }}

# DEPRECATED: If true, the revocation list will be checked for cached tokens.
# This requires that PKI tokens are configured on the identity server. (boolean
# value)
# This option is deprecated for removal since Ocata.
# Its value may be silently ignored in the future.
# Reason: PKI token format is no longer supported.
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.check_revocations_for_cached }}#{{ end }}check_revocations_for_cached = {{ .keystone_authtoken.keystonemiddleware.auth_token.check_revocations_for_cached | default "false" }}

# DEPRECATED: Hash algorithms to use for hashing PKI tokens. This may be a
# single algorithm or multiple. The algorithms are those supported by Python
# standard hashlib.new(). The hashes will be tried in the order given, so put
# the preferred one first for performance. The result of the first hash will be
# stored in the cache. This will typically be set to multiple values only while
# migrating from a less secure algorithm to a more secure one. Once all the old
# tokens are expired this option should be set to a single value for better
# performance. (list value)
# This option is deprecated for removal since Ocata.
# Its value may be silently ignored in the future.
# Reason: PKI token format is no longer supported.
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.hash_algorithms }}#{{ end }}hash_algorithms = {{ .keystone_authtoken.keystonemiddleware.auth_token.hash_algorithms | default "md5" }}

# A choice of roles that must be present in a service token. Service tokens are
# allowed to request that an expired token can be used and so this check should
# tightly control that only actual services should be sending this token. Roles
# here are applied as an ANY check so any role in this list must be present. For
# backwards compatibility reasons this currently only affects the allow_expired
# check. (list value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.service_token_roles }}#{{ end }}service_token_roles = {{ .keystone_authtoken.keystonemiddleware.auth_token.service_token_roles | default "service" }}

# For backwards compatibility reasons we must let valid service tokens pass that
# don't pass the service_token_roles check as valid. Setting this true will
# become the default in a future release and should be enabled if possible.
# (boolean value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.service_token_roles_required }}#{{ end }}service_token_roles_required = {{ .keystone_authtoken.keystonemiddleware.auth_token.service_token_roles_required | default "false" }}

# Authentication type to load (string value)
# Deprecated group/name - [keystone_authtoken]/auth_plugin
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.auth_type }}#{{ end }}auth_type = {{ .keystone_authtoken.keystonemiddleware.auth_token.auth_type | default "<None>" }}

# Config Section from which to load plugin specific options (string value)
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.auth_section }}#{{ end }}auth_section = {{ .keystone_authtoken.keystonemiddleware.auth_token.auth_section | default "<None>" }}

#
# From processing_engine
#

# Authentication URL (string value)
# from .keystone_authtoken.processing_engine.auth_url
{{ if not .keystone_authtoken.processing_engine.auth_url }}#{{ end }}auth_url = {{ .keystone_authtoken.processing_engine.auth_url | default "<None>" }}

# Domain ID to scope to (string value)
# from .keystone_authtoken.processing_engine.domain_id
{{ if not .keystone_authtoken.processing_engine.domain_id }}#{{ end }}domain_id = {{ .keystone_authtoken.processing_engine.domain_id | default "<None>" }}

# Domain name to scope to (string value)
# from .keystone_authtoken.processing_engine.domain_name
{{ if not .keystone_authtoken.processing_engine.domain_name }}#{{ end }}domain_name = {{ .keystone_authtoken.processing_engine.domain_name | default "<None>" }}

# Project ID to scope to (string value)
# Deprecated group/name - [keystone_authtoken]/tenant-id
# from .keystone_authtoken.processing_engine.project_id
{{ if not .keystone_authtoken.processing_engine.project_id }}#{{ end }}project_id = {{ .keystone_authtoken.processing_engine.project_id | default "<None>" }}

# Project name to scope to (string value)
# Deprecated group/name - [keystone_authtoken]/tenant-name
# from .keystone_authtoken.processing_engine.project_name
{{ if not .keystone_authtoken.processing_engine.project_name }}#{{ end }}project_name = {{ .keystone_authtoken.processing_engine.project_name | default "<None>" }}

# Domain ID containing project (string value)
# from .keystone_authtoken.processing_engine.project_domain_id
{{ if not .keystone_authtoken.processing_engine.project_domain_id }}#{{ end }}project_domain_id = {{ .keystone_authtoken.processing_engine.project_domain_id | default "<None>" }}

# Domain name containing project (string value)
# from .keystone_authtoken.processing_engine.project_domain_name
{{ if not .keystone_authtoken.processing_engine.project_domain_name }}#{{ end }}project_domain_name = {{ .keystone_authtoken.processing_engine.project_domain_name | default "<None>" }}

# Trust ID (string value)
# from .keystone_authtoken.processing_engine.trust_id
{{ if not .keystone_authtoken.processing_engine.trust_id }}#{{ end }}trust_id = {{ .keystone_authtoken.processing_engine.trust_id | default "<None>" }}

# Optional domain ID to use with v3 and v2 parameters. It will be used for both
# the user and project domain in v3 and ignored in v2 authentication. (string
# value)
# from .keystone_authtoken.processing_engine.default_domain_id
{{ if not .keystone_authtoken.processing_engine.default_domain_id }}#{{ end }}default_domain_id = {{ .keystone_authtoken.processing_engine.default_domain_id | default "<None>" }}

# Optional domain name to use with v3 API and v2 parameters. It will be used for
# both the user and project domain in v3 and ignored in v2 authentication.
# (string value)
# from .keystone_authtoken.processing_engine.default_domain_name
{{ if not .keystone_authtoken.processing_engine.default_domain_name }}#{{ end }}default_domain_name = {{ .keystone_authtoken.processing_engine.default_domain_name | default "<None>" }}

# User id (string value)
# from .keystone_authtoken.processing_engine.user_id
{{ if not .keystone_authtoken.processing_engine.user_id }}#{{ end }}user_id = {{ .keystone_authtoken.processing_engine.user_id | default "<None>" }}

# Username (string value)
# Deprecated group/name - [keystone_authtoken]/user-name
# from .keystone_authtoken.processing_engine.username
{{ if not .keystone_authtoken.processing_engine.username }}#{{ end }}username = {{ .keystone_authtoken.processing_engine.username | default "<None>" }}

# User's domain id (string value)
# from .keystone_authtoken.processing_engine.user_domain_id
{{ if not .keystone_authtoken.processing_engine.user_domain_id }}#{{ end }}user_domain_id = {{ .keystone_authtoken.processing_engine.user_domain_id | default "<None>" }}

# User's domain name (string value)
# from .keystone_authtoken.processing_engine.user_domain_name
{{ if not .keystone_authtoken.processing_engine.user_domain_name }}#{{ end }}user_domain_name = {{ .keystone_authtoken.processing_engine.user_domain_name | default "<None>" }}

# User's password (string value)
# from .keystone_authtoken.processing_engine.password
{{ if not .keystone_authtoken.processing_engine.password }}#{{ end }}password = {{ .keystone_authtoken.processing_engine.password | default "<None>" }}

[oslo_middleware]

#
# From oslo.middleware
#

# The maximum body size for each  request, in bytes. (integer value)
# Deprecated group/name - [DEFAULT]/osapi_max_request_body_size
# Deprecated group/name - [DEFAULT]/max_request_body_size
{{ if not .oslo_middleware.max_request_body_size }}#{{ end }}max_request_body_size = {{ .oslo_middleware.max_request_body_size | default "114688" }}

# DEPRECATED: The HTTP Header that will be used to determine what the original
# request protocol scheme was, even if it was hidden by a SSL termination proxy.
# (string value)
# This option is deprecated for removal.
# Its value may be silently ignored in the future.
{{ if not .oslo_middleware.secure_proxy_ssl_header }}#{{ end }}secure_proxy_ssl_header = {{ .oslo_middleware.secure_proxy_ssl_header | default "X-Forwarded-Proto" }}

# Whether the application is behind a proxy or not. This determines if the
# middleware should parse the headers or not. (boolean value)
{{ if not .oslo_middleware.enable_proxy_headers_parsing }}#{{ end }}enable_proxy_headers_parsing = {{ .oslo_middleware.enable_proxy_headers_parsing | default "false" }}

[oslo_policy]

#
# From oslo.policy
#

# The file that defines policies. (string value)
{{ if not .oslo_policy.policy_file }}#{{ end }}policy_file = {{ .oslo_policy.policy_file | default "policy.yaml" }}

# Default rule. Enforced when a requested rule is not found. (string value)
{{ if not .oslo_policy.policy_default_rule }}#{{ end }}policy_default_rule = {{ .oslo_policy.policy_default_rule | default "default" }}

# Directories where policy configuration files are stored. They can be relative
# to any directory in the search path defined by the config_dir option, or
# absolute paths. The file defined by policy_file must exist for these
# directories to be searched.  Missing or empty directories are ignored. (multi
# valued)
{{ if not .oslo_policy.policy_dirs }}#{{ end }}policy_dirs = {{ .oslo_policy.policy_dirs | default "policy.d" }}

{{- end -}}
