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

{{ include "drydock.conf.drydock_values_skeleton" .Values.conf.drydock | trunc 0 }}
{{ include "drydock.conf.drydock" .Values.conf.drydock }}


{{- define "drydock.conf.drydock_values_skeleton" -}}

{{- if not .default -}}{{- set . "default" dict -}}{{- end -}}
{{- if not .default.drydock_provisioner -}}{{- set .default "drydock_provisioner" dict -}}{{- end -}}
{{- if not .bootdata -}}{{- set . "bootdata" dict -}}{{- end -}}
{{- if not .bootdata.drydock_provisioner -}}{{- set .bootdata "drydock_provisioner" dict -}}{{- end -}}
{{- if not .keystone_authtoken -}}{{- set . "keystone_authtoken" dict -}}{{- end -}}
{{- if not .keystone_authtoken.keystonemiddleware -}}{{- set .keystone_authtoken "keystonemiddleware" dict -}}{{- end -}}
{{- if not .keystone_authtoken.keystonemiddleware.auth_token -}}{{- set .keystone_authtoken.keystonemiddleware "auth_token" dict -}}{{- end -}}
{{- if not .keystone_authtoken.drydock_provisioner -}}{{- set .keystone_authtoken "drydock_provisioner" dict -}}{{- end -}}
{{- if not .logging -}}{{- set . "logging" dict -}}{{- end -}}
{{- if not .logging.drydock_provisioner -}}{{- set .logging "drydock_provisioner" dict -}}{{- end -}}
{{- if not .maasdriver -}}{{- set . "maasdriver" dict -}}{{- end -}}
{{- if not .maasdriver.drydock_provisioner -}}{{- set .maasdriver "drydock_provisioner" dict -}}{{- end -}}
{{- if not .oslo_policy -}}{{- set . "oslo_policy" dict -}}{{- end -}}
{{- if not .oslo_policy.oslo -}}{{- set .oslo_policy "oslo" dict -}}{{- end -}}
{{- if not .oslo_policy.oslo.policy -}}{{- set .oslo_policy.oslo "policy" dict -}}{{- end -}}
{{- if not .plugins -}}{{- set . "plugins" dict -}}{{- end -}}
{{- if not .plugins.drydock_provisioner -}}{{- set .plugins "drydock_provisioner" dict -}}{{- end -}}
{{- if not .timeouts -}}{{- set . "timeouts" dict -}}{{- end -}}
{{- if not .timeouts.drydock_provisioner -}}{{- set .timeouts "drydock_provisioner" dict -}}{{- end -}}

{{- end -}}


{{- define "drydock.conf.drydock" -}}

[DEFAULT]

#
# From drydock_provisioner
#

# Polling interval in seconds for checking subtask or downstream status (integer
# value)
# from .default.drydock_provisioner.poll_interval
{{ if not .default.drydock_provisioner.poll_interval }}#{{ end }}poll_interval = {{ .default.drydock_provisioner.poll_interval | default "10" }}


[bootdata]

#
# From drydock_provisioner
#

# Path to file to distribute for prom_init.sh (string value)
# from .bootdata.drydock_provisioner.prom_init
{{ if not .bootdata.drydock_provisioner.prom_init }}#{{ end }}prom_init = {{ .bootdata.drydock_provisioner.prom_init | default "/etc/drydock/bootdata/join.sh" }}


[keystone_authtoken]

#
# From keystonemiddleware.auth_token
#

# Complete "public" Identity API endpoint. This endpoint should not be an
# "admin" endpoint, as it should be accessible by all end users. Unauthenticated
# clients are redirected to this endpoint to authenticate. Although this
# endpoint should  ideally be unversioned, client support in the wild varies.
# If you're using a versioned v2 endpoint here, then this  should *not* be the
# same endpoint the service user utilizes  for validating tokens, because normal
# end users may not be  able to reach that endpoint. (string value)
# from .keystone_authtoken.keystonemiddleware.auth_token.auth_uri
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.auth_uri }}#{{ end }}auth_uri = {{ .keystone_authtoken.keystonemiddleware.auth_token.auth_uri | default "<None>" }}

# API version of the admin Identity API endpoint. (string value)
# from .keystone_authtoken.keystonemiddleware.auth_token.auth_version
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.auth_version }}#{{ end }}auth_version = {{ .keystone_authtoken.keystonemiddleware.auth_token.auth_version | default "<None>" }}

# Do not handle authorization requests within the middleware, but delegate the
# authorization decision to downstream WSGI components. (boolean value)
# from .keystone_authtoken.keystonemiddleware.auth_token.delay_auth_decision
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.delay_auth_decision }}#{{ end }}delay_auth_decision = {{ .keystone_authtoken.keystonemiddleware.auth_token.delay_auth_decision | default "false" }}

# Request timeout value for communicating with Identity API server. (integer
# value)
# from .keystone_authtoken.keystonemiddleware.auth_token.http_connect_timeout
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.http_connect_timeout }}#{{ end }}http_connect_timeout = {{ .keystone_authtoken.keystonemiddleware.auth_token.http_connect_timeout | default "<None>" }}

# How many times are we trying to reconnect when communicating with Identity API
# Server. (integer value)
# from .keystone_authtoken.keystonemiddleware.auth_token.http_request_max_retries
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.http_request_max_retries }}#{{ end }}http_request_max_retries = {{ .keystone_authtoken.keystonemiddleware.auth_token.http_request_max_retries | default "3" }}

# Request environment key where the Swift cache object is stored. When
# auth_token middleware is deployed with a Swift cache, use this option to have
# the middleware share a caching backend with swift. Otherwise, use the
# ``memcached_servers`` option instead. (string value)
# from .keystone_authtoken.keystonemiddleware.auth_token.cache
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.cache }}#{{ end }}cache = {{ .keystone_authtoken.keystonemiddleware.auth_token.cache | default "<None>" }}

# Required if identity server requires client certificate (string value)
# from .keystone_authtoken.keystonemiddleware.auth_token.certfile
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.certfile }}#{{ end }}certfile = {{ .keystone_authtoken.keystonemiddleware.auth_token.certfile | default "<None>" }}

# Required if identity server requires client certificate (string value)
# from .keystone_authtoken.keystonemiddleware.auth_token.keyfile
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.keyfile }}#{{ end }}keyfile = {{ .keystone_authtoken.keystonemiddleware.auth_token.keyfile | default "<None>" }}

# A PEM encoded Certificate Authority to use when verifying HTTPs connections.
# Defaults to system CAs. (string value)
# from .keystone_authtoken.keystonemiddleware.auth_token.cafile
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.cafile }}#{{ end }}cafile = {{ .keystone_authtoken.keystonemiddleware.auth_token.cafile | default "<None>" }}

# Verify HTTPS connections. (boolean value)
# from .keystone_authtoken.keystonemiddleware.auth_token.insecure
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.insecure }}#{{ end }}insecure = {{ .keystone_authtoken.keystonemiddleware.auth_token.insecure | default "false" }}

# The region in which the identity server can be found. (string value)
# from .keystone_authtoken.keystonemiddleware.auth_token.region_name
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.region_name }}#{{ end }}region_name = {{ .keystone_authtoken.keystonemiddleware.auth_token.region_name | default "<None>" }}

# Directory used to cache files related to PKI tokens. (string value)
# from .keystone_authtoken.keystonemiddleware.auth_token.signing_dir
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.signing_dir }}#{{ end }}signing_dir = {{ .keystone_authtoken.keystonemiddleware.auth_token.signing_dir | default "<None>" }}

# Optionally specify a list of memcached server(s) to use for caching. If left
# undefined, tokens will instead be cached in-process. (list value)
# Deprecated group/name - [keystone_authtoken]/memcache_servers
# from .keystone_authtoken.keystonemiddleware.auth_token.memcached_servers
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcached_servers }}#{{ end }}memcached_servers = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcached_servers | default "<None>" }}

# In order to prevent excessive effort spent validating tokens, the middleware
# caches previously-seen tokens for a configurable duration (in seconds). Set to
# -1 to disable caching completely. (integer value)
# from .keystone_authtoken.keystonemiddleware.auth_token.token_cache_time
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.token_cache_time }}#{{ end }}token_cache_time = {{ .keystone_authtoken.keystonemiddleware.auth_token.token_cache_time | default "300" }}

# Determines the frequency at which the list of revoked tokens is retrieved from
# the Identity service (in seconds). A high number of revocation events combined
# with a low cache duration may significantly reduce performance. Only valid for
# PKI tokens. (integer value)
# from .keystone_authtoken.keystonemiddleware.auth_token.revocation_cache_time
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.revocation_cache_time }}#{{ end }}revocation_cache_time = {{ .keystone_authtoken.keystonemiddleware.auth_token.revocation_cache_time | default "10" }}

# (Optional) If defined, indicate whether token data should be authenticated or
# authenticated and encrypted. If MAC, token data is authenticated (with HMAC)
# in the cache. If ENCRYPT, token data is encrypted and authenticated in the
# cache. If the value is not one of these options or empty, auth_token will
# raise an exception on initialization. (string value)
# Allowed values: None, MAC, ENCRYPT
# from .keystone_authtoken.keystonemiddleware.auth_token.memcache_security_strategy
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_security_strategy }}#{{ end }}memcache_security_strategy = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_security_strategy | default "None" }}

# (Optional, mandatory if memcache_security_strategy is defined) This string is
# used for key derivation. (string value)
# from .keystone_authtoken.keystonemiddleware.auth_token.memcache_secret_key
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_secret_key }}#{{ end }}memcache_secret_key = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_secret_key | default "<None>" }}

# (Optional) Number of seconds memcached server is considered dead before it is
# tried again. (integer value)
# from .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_dead_retry
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_dead_retry }}#{{ end }}memcache_pool_dead_retry = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_dead_retry | default "300" }}

# (Optional) Maximum total number of open connections to every memcached server.
# (integer value)
# from .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_maxsize
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_maxsize }}#{{ end }}memcache_pool_maxsize = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_maxsize | default "10" }}

# (Optional) Socket timeout in seconds for communicating with a memcached
# server. (integer value)
# from .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_socket_timeout
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_socket_timeout }}#{{ end }}memcache_pool_socket_timeout = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_socket_timeout | default "3" }}

# (Optional) Number of seconds a connection to memcached is held unused in the
# pool before it is closed. (integer value)
# from .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_unused_timeout
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_unused_timeout }}#{{ end }}memcache_pool_unused_timeout = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_unused_timeout | default "60" }}

# (Optional) Number of seconds that an operation will wait to get a memcached
# client connection from the pool. (integer value)
# from .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_conn_get_timeout
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_conn_get_timeout }}#{{ end }}memcache_pool_conn_get_timeout = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_pool_conn_get_timeout | default "10" }}

# (Optional) Use the advanced (eventlet safe) memcached client pool. The
# advanced pool will only work under python 2.x. (boolean value)
# from .keystone_authtoken.keystonemiddleware.auth_token.memcache_use_advanced_pool
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.memcache_use_advanced_pool }}#{{ end }}memcache_use_advanced_pool = {{ .keystone_authtoken.keystonemiddleware.auth_token.memcache_use_advanced_pool | default "false" }}

# (Optional) Indicate whether to set the X-Service-Catalog header. If False,
# middleware will not ask for service catalog on token validation and will not
# set the X-Service-Catalog header. (boolean value)
# from .keystone_authtoken.keystonemiddleware.auth_token.include_service_catalog
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.include_service_catalog }}#{{ end }}include_service_catalog = {{ .keystone_authtoken.keystonemiddleware.auth_token.include_service_catalog | default "true" }}

# Used to control the use and type of token binding. Can be set to: "disabled"
# to not check token binding. "permissive" (default) to validate binding
# information if the bind type is of a form known to the server and ignore it if
# not. "strict" like "permissive" but if the bind type is unknown the token will
# be rejected. "required" any form of token binding is needed to be allowed.
# Finally the name of a binding method that must be present in tokens. (string
# value)
# from .keystone_authtoken.keystonemiddleware.auth_token.enforce_token_bind
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.enforce_token_bind }}#{{ end }}enforce_token_bind = {{ .keystone_authtoken.keystonemiddleware.auth_token.enforce_token_bind | default "permissive" }}

# If true, the revocation list will be checked for cached tokens. This requires
# that PKI tokens are configured on the identity server. (boolean value)
# from .keystone_authtoken.keystonemiddleware.auth_token.check_revocations_for_cached
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.check_revocations_for_cached }}#{{ end }}check_revocations_for_cached = {{ .keystone_authtoken.keystonemiddleware.auth_token.check_revocations_for_cached | default "false" }}

# Hash algorithms to use for hashing PKI tokens. This may be a single algorithm
# or multiple. The algorithms are those supported by Python standard
# hashlib.new(). The hashes will be tried in the order given, so put the
# preferred one first for performance. The result of the first hash will be
# stored in the cache. This will typically be set to multiple values only while
# migrating from a less secure algorithm to a more secure one. Once all the old
# tokens are expired this option should be set to a single value for better
# performance. (list value)
# from .keystone_authtoken.keystonemiddleware.auth_token.hash_algorithms
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.hash_algorithms }}#{{ end }}hash_algorithms = {{ .keystone_authtoken.keystonemiddleware.auth_token.hash_algorithms | default "md5" }}

# Authentication type to load (string value)
# Deprecated group/name - [keystone_authtoken]/auth_plugin
# from .keystone_authtoken.keystonemiddleware.auth_token.auth_type
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.auth_type }}#{{ end }}auth_type = {{ .keystone_authtoken.keystonemiddleware.auth_token.auth_type | default "<None>" }}

# Config Section from which to load plugin specific options (string value)
# from .keystone_authtoken.keystonemiddleware.auth_token.auth_section
{{ if not .keystone_authtoken.keystonemiddleware.auth_token.auth_section }}#{{ end }}auth_section = {{ .keystone_authtoken.keystonemiddleware.auth_token.auth_section | default "<None>" }}



#
# From drydock_provisioner
#

# Authentication URL (string value)
# from .keystone_authtoken.drydock_provisioner.auth_url
{{ if not .keystone_authtoken.drydock_provisioner.auth_url }}#{{ end }}auth_url = {{ .keystone_authtoken.drydock_provisioner.auth_url | default "<None>" }}

# Domain ID to scope to (string value)
# from .keystone_authtoken.drydock_provisioner.domain_id
{{ if not .keystone_authtoken.drydock_provisioner.domain_id }}#{{ end }}domain_id = {{ .keystone_authtoken.drydock_provisioner.domain_id | default "<None>" }}

# Domain name to scope to (string value)
# from .keystone_authtoken.drydock_provisioner.domain_name
{{ if not .keystone_authtoken.drydock_provisioner.domain_name }}#{{ end }}domain_name = {{ .keystone_authtoken.drydock_provisioner.domain_name | default "<None>" }}

# Project ID to scope to (string value)
# Deprecated group/name - [keystone_authtoken]/tenant-id
# from .keystone_authtoken.drydock_provisioner.project_id
{{ if not .keystone_authtoken.drydock_provisioner.project_id }}#{{ end }}project_id = {{ .keystone_authtoken.drydock_provisioner.project_id | default "<None>" }}

# Project name to scope to (string value)
# Deprecated group/name - [keystone_authtoken]/tenant-name
# from .keystone_authtoken.drydock_provisioner.project_name
{{ if not .keystone_authtoken.drydock_provisioner.project_name }}#{{ end }}project_name = {{ .keystone_authtoken.drydock_provisioner.project_name | default "<None>" }}

# Domain ID containing project (string value)
# from .keystone_authtoken.drydock_provisioner.project_domain_id
{{ if not .keystone_authtoken.drydock_provisioner.project_domain_id }}#{{ end }}project_domain_id = {{ .keystone_authtoken.drydock_provisioner.project_domain_id | default "<None>" }}

# Domain name containing project (string value)
# from .keystone_authtoken.drydock_provisioner.project_domain_name
{{ if not .keystone_authtoken.drydock_provisioner.project_domain_name }}#{{ end }}project_domain_name = {{ .keystone_authtoken.drydock_provisioner.project_domain_name | default "<None>" }}

# Trust ID (string value)
# from .keystone_authtoken.drydock_provisioner.trust_id
{{ if not .keystone_authtoken.drydock_provisioner.trust_id }}#{{ end }}trust_id = {{ .keystone_authtoken.drydock_provisioner.trust_id | default "<None>" }}

# Optional domain ID to use with v3 and v2 parameters. It will be used for both
# the user and project domain in v3 and ignored in v2 authentication. (string
# value)
# from .keystone_authtoken.drydock_provisioner.default_domain_id
{{ if not .keystone_authtoken.drydock_provisioner.default_domain_id }}#{{ end }}default_domain_id = {{ .keystone_authtoken.drydock_provisioner.default_domain_id | default "<None>" }}

# Optional domain name to use with v3 API and v2 parameters. It will be used for
# both the user and project domain in v3 and ignored in v2 authentication.
# (string value)
# from .keystone_authtoken.drydock_provisioner.default_domain_name
{{ if not .keystone_authtoken.drydock_provisioner.default_domain_name }}#{{ end }}default_domain_name = {{ .keystone_authtoken.drydock_provisioner.default_domain_name | default "<None>" }}

# User id (string value)
# from .keystone_authtoken.drydock_provisioner.user_id
{{ if not .keystone_authtoken.drydock_provisioner.user_id }}#{{ end }}user_id = {{ .keystone_authtoken.drydock_provisioner.user_id | default "<None>" }}

# Username (string value)
# Deprecated group/name - [keystone_authtoken]/user-name
# from .keystone_authtoken.drydock_provisioner.username
{{ if not .keystone_authtoken.drydock_provisioner.username }}#{{ end }}username = {{ .keystone_authtoken.drydock_provisioner.username | default "<None>" }}

# User's domain id (string value)
# from .keystone_authtoken.drydock_provisioner.user_domain_id
{{ if not .keystone_authtoken.drydock_provisioner.user_domain_id }}#{{ end }}user_domain_id = {{ .keystone_authtoken.drydock_provisioner.user_domain_id | default "<None>" }}

# User's domain name (string value)
# from .keystone_authtoken.drydock_provisioner.user_domain_name
{{ if not .keystone_authtoken.drydock_provisioner.user_domain_name }}#{{ end }}user_domain_name = {{ .keystone_authtoken.drydock_provisioner.user_domain_name | default "<None>" }}

# User's password (string value)
# from .keystone_authtoken.drydock_provisioner.password
{{ if not .keystone_authtoken.drydock_provisioner.password }}#{{ end }}password = {{ .keystone_authtoken.drydock_provisioner.password | default "<None>" }}


[logging]

#
# From drydock_provisioner
#

# Global log level for Drydock (string value)
# from .logging.drydock_provisioner.log_level
{{ if not .logging.drydock_provisioner.log_level }}#{{ end }}log_level = {{ .logging.drydock_provisioner.log_level | default "INFO" }}

# Logger name for the top-level logger (string value)
# from .logging.drydock_provisioner.global_logger_name
{{ if not .logging.drydock_provisioner.global_logger_name }}#{{ end }}global_logger_name = {{ .logging.drydock_provisioner.global_logger_name | default "drydock" }}

# Logger name for OOB driver logging (string value)
# from .logging.drydock_provisioner.oobdriver_logger_name
{{ if not .logging.drydock_provisioner.oobdriver_logger_name }}#{{ end }}oobdriver_logger_name = {{ .logging.drydock_provisioner.oobdriver_logger_name | default "${global_logger_name}.oobdriver" }}

# Logger name for Node driver logging (string value)
# from .logging.drydock_provisioner.nodedriver_logger_name
{{ if not .logging.drydock_provisioner.nodedriver_logger_name }}#{{ end }}nodedriver_logger_name = {{ .logging.drydock_provisioner.nodedriver_logger_name | default "${global_logger_name}.nodedriver" }}

# Logger name for API server logging (string value)
# from .logging.drydock_provisioner.control_logger_name
{{ if not .logging.drydock_provisioner.control_logger_name }}#{{ end }}control_logger_name = {{ .logging.drydock_provisioner.control_logger_name | default "${global_logger_name}.control" }}


[maasdriver]

#
# From drydock_provisioner
#

# The API key for accessing MaaS (string value)
# from .maasdriver.drydock_provisioner.maas_api_key
{{ if not .maasdriver.drydock_provisioner.maas_api_key }}#{{ end }}maas_api_key = {{ .maasdriver.drydock_provisioner.maas_api_key | default "<None>" }}

# The URL for accessing MaaS API (string value)
# from .maasdriver.drydock_provisioner.maas_api_url
{{ if not .maasdriver.drydock_provisioner.maas_api_url }}#{{ end }}maas_api_url = {{ .maasdriver.drydock_provisioner.maas_api_url | default "<None>" }}

# Polling interval for querying MaaS status in seconds (integer value)
# from .maasdriver.drydock_provisioner.poll_interval
{{ if not .maasdriver.drydock_provisioner.poll_interval }}#{{ end }}poll_interval = {{ .maasdriver.drydock_provisioner.poll_interval | default "10" }}


[oslo_policy]

#
# From oslo.policy
#

# The file that defines policies. (string value)
# Deprecated group/name - [DEFAULT]/policy_file
# from .oslo_policy.oslo.policy.policy_file
{{ if not .oslo_policy.oslo.policy.policy_file }}#{{ end }}policy_file = {{ .oslo_policy.oslo.policy.policy_file | default "policy.json" }}

# Default rule. Enforced when a requested rule is not found. (string value)
# Deprecated group/name - [DEFAULT]/policy_default_rule
# from .oslo_policy.oslo.policy.policy_default_rule
{{ if not .oslo_policy.oslo.policy.policy_default_rule }}#{{ end }}policy_default_rule = {{ .oslo_policy.oslo.policy.policy_default_rule | default "default" }}

# Directories where policy configuration files are stored. They can be relative
# to any directory in the search path defined by the config_dir option, or
# absolute paths. The file defined by policy_file must exist for these
# directories to be searched.  Missing or empty directories are ignored. (multi
# valued)
# Deprecated group/name - [DEFAULT]/policy_dirs
# from .oslo_policy.oslo.policy.policy_dirs (multiopt)
{{ if not .oslo_policy.oslo.policy.policy_dirs }}#policy_dirs = {{ .oslo_policy.oslo.policy.policy_dirs | default "policy.d" }}{{ else }}{{ range .oslo_policy.oslo.policy.policy_dirs }}policy_dirs = {{ . }}
{{ end }}{{ end }}

[plugins]

#
# From drydock_provisioner
#

# Module path string of a input ingester to enable (multi valued)
# from .plugins.drydock_provisioner.ingester (multiopt)
{{ if not .plugins.drydock_provisioner.ingester }}#ingester = {{ .plugins.drydock_provisioner.ingester | default "drydock_provisioner.ingester.plugins.yaml.YamlIngester" }}{{ else }}{{ range .plugins.drydock_provisioner.ingester }}ingester = {{ . }}
{{ end }}{{ end }}

# Module path string of a OOB driver to enable (multi valued)
# from .plugins.drydock_provisioner.oob_driver (multiopt)
{{ if not .plugins.drydock_provisioner.oob_driver }}#oob_driver = {{ .plugins.drydock_provisioner.oob_driver | default "drydock_provisioner.drivers.oob.pyghmi_driver.PyghmiDriver" }}{{ else }}{{ range .plugins.drydock_provisioner.oob_driver }}oob_driver = {{ . }}
{{ end }}{{ end }}

# Module path string of the Node driver to enable (string value)
# from .plugins.drydock_provisioner.node_driver
{{ if not .plugins.drydock_provisioner.node_driver }}#{{ end }}node_driver = {{ .plugins.drydock_provisioner.node_driver | default "drydock_provisioner.drivers.node.maasdriver.driver.MaasNodeDriver" }}

# Module path string of the Network driver enable (string value)
# from .plugins.drydock_provisioner.network_driver
{{ if not .plugins.drydock_provisioner.network_driver }}#{{ end }}network_driver = {{ .plugins.drydock_provisioner.network_driver | default "<None>" }}


[timeouts]

#
# From drydock_provisioner
#

# Fallback timeout when a specific one is not configured (integer value)
# from .timeouts.drydock_provisioner.drydock_timeout
{{ if not .timeouts.drydock_provisioner.drydock_timeout }}#{{ end }}drydock_timeout = {{ .timeouts.drydock_provisioner.drydock_timeout | default "5" }}

# Timeout in minutes for creating site network templates (integer value)
# from .timeouts.drydock_provisioner.create_network_template
{{ if not .timeouts.drydock_provisioner.create_network_template }}#{{ end }}create_network_template = {{ .timeouts.drydock_provisioner.create_network_template | default "2" }}

# Timeout in minutes for creating user credentials (integer value)
# from .timeouts.drydock_provisioner.configure_user_credentials
{{ if not .timeouts.drydock_provisioner.configure_user_credentials }}#{{ end }}configure_user_credentials = {{ .timeouts.drydock_provisioner.configure_user_credentials | default "2" }}

# Timeout in minutes for initial node identification (integer value)
# from .timeouts.drydock_provisioner.identify_node
{{ if not .timeouts.drydock_provisioner.identify_node }}#{{ end }}identify_node = {{ .timeouts.drydock_provisioner.identify_node | default "10" }}

# Timeout in minutes for node commissioning and hardware configuration (integer
# value)
# from .timeouts.drydock_provisioner.configure_hardware
{{ if not .timeouts.drydock_provisioner.configure_hardware }}#{{ end }}configure_hardware = {{ .timeouts.drydock_provisioner.configure_hardware | default "30" }}

# Timeout in minutes for configuring node networking (integer value)
# from .timeouts.drydock_provisioner.apply_node_networking
{{ if not .timeouts.drydock_provisioner.apply_node_networking }}#{{ end }}apply_node_networking = {{ .timeouts.drydock_provisioner.apply_node_networking | default "5" }}

# Timeout in minutes for configuring node platform (integer value)
# from .timeouts.drydock_provisioner.apply_node_platform
{{ if not .timeouts.drydock_provisioner.apply_node_platform }}#{{ end }}apply_node_platform = {{ .timeouts.drydock_provisioner.apply_node_platform | default "5" }}

# Timeout in minutes for deploying a node (integer value)
# from .timeouts.drydock_provisioner.deploy_node
{{ if not .timeouts.drydock_provisioner.deploy_node }}#{{ end }}deploy_node = {{ .timeouts.drydock_provisioner.deploy_node | default "45" }}

{{- end -}}
