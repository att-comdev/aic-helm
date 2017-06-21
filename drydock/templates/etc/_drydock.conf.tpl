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

{{- if not .authentication -}}{{- set . "authentication" dict -}}{{- end -}}
{{- if not .authentication.drydock_provisioner -}}{{- set .authentication "drydock_provisioner" dict -}}{{- end -}}
{{- if not .logging -}}{{- set . "logging" dict -}}{{- end -}}
{{- if not .logging.drydock_provisioner -}}{{- set .logging "drydock_provisioner" dict -}}{{- end -}}
{{- if not .maasdriver -}}{{- set . "maasdriver" dict -}}{{- end -}}
{{- if not .maasdriver.drydock_provisioner -}}{{- set .maasdriver "drydock_provisioner" dict -}}{{- end -}}
{{- if not .plugins -}}{{- set . "plugins" dict -}}{{- end -}}
{{- if not .plugins.drydock_provisioner -}}{{- set .plugins "drydock_provisioner" dict -}}{{- end -}}
{{- if not .timeouts -}}{{- set . "timeouts" dict -}}{{- end -}}
{{- if not .timeouts.drydock_provisioner -}}{{- set .timeouts "drydock_provisioner" dict -}}{{- end -}}

{{- end -}}


{{- define "drydock.conf.drydock" -}}

[DEFAULT]


[authentication]

#
# From drydock_provisioner
#

# X-Auth-Token value to bypass backend authentication (string value)
# from .authentication.drydock_provisioner.admin_token
{{ if not .authentication.drydock_provisioner.admin_token }}#{{ end }}admin_token = {{ .authentication.drydock_provisioner.admin_token | default "bigboss" }}

# Can backend authentication be bypassed? (boolean value)
# from .authentication.drydock_provisioner.bypass_enabled
{{ if not .authentication.drydock_provisioner.bypass_enabled }}#{{ end }}bypass_enabled = {{ .authentication.drydock_provisioner.bypass_enabled | default "false" }}


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


[plugins]

#
# From drydock_provisioner
#

# Module path string of a input ingester to enable (multi valued)
# from .plugins.drydock_provisioner.ingester (multiopt)
{{ if not .plugins.drydock_provisioner.ingester }}#ingester = {{ .plugins.drydock_provisioner.ingester | default "drydock_provisioner.ingester.plugins.yaml.YamlIngester" }}{{ else }}{{ range .plugins.drydock_provisioner.ingester }}ingester = {{ . }}{{ end }}{{ end }}

# Module path string of a OOB driver to enable (multi valued)
# from .plugins.drydock_provisioner.oob_driver (multiopt)
{{ if not .plugins.drydock_provisioner.oob_driver }}#oob_driver = {{ .plugins.drydock_provisioner.oob_driver | default "drydock_provisioner.drivers.oob.pyghmi_driver.PyghmiDriver" }}{{ else }}{{ range .plugins.drydock_provisioner.oob_driver }}oob_driver = {{ . }}{{ end }}{{ end }}

# Module path string of the Node driver to enable (string value)
# from .plugins.drydock_provisioner.node_driver
{{ if not .plugins.drydock_provisioner.node_driver }}#{{ end }}node_driver = {{ .plugins.drydock_provisioner.node_driver | default "drydock_provisioner.drivers.node.maasdriver.driver.MaasNodeDriver" }}

# Module path string of the Network driver to enable (string value)
# from .plugins.drydock_provisioner.network_driver
{{ if not .plugins.drydock_provisioner.network_driver }}#{{ end }}network_driver = {{ .plugins.drydock_provisioner.network_driver | default "<None>" }}


[timeouts]

#
# From drydock_provisioner
#

# Fallback timeout when a specific one is not configured (integer
# value)
# from .timeouts.drydock_provisioner.drydock_timeout
{{ if not .timeouts.drydock_provisioner.drydock_timeout }}#{{ end }}drydock_timeout = {{ .timeouts.drydock_provisioner.drydock_timeout | default "5" }}

# Timeout in minutes for creating site network templates (integer
# value)
# from .timeouts.drydock_provisioner.create_network_template
{{ if not .timeouts.drydock_provisioner.create_network_template }}#{{ end }}create_network_template = {{ .timeouts.drydock_provisioner.create_network_template | default "2" }}

# Timeout in minutes for initial node identification (integer value)
# from .timeouts.drydock_provisioner.identify_node
{{ if not .timeouts.drydock_provisioner.identify_node }}#{{ end }}identify_node = {{ .timeouts.drydock_provisioner.identify_node | default "10" }}

# Timeout in minutes for node commissioning and hardware configuration
# (integer value)
# from .timeouts.drydock_provisioner.configure_hardware
{{ if not .timeouts.drydock_provisioner.configure_hardware }}#{{ end }}configure_hardware = {{ .timeouts.drydock_provisioner.configure_hardware | default "30" }}

# Timeout in minutes for configuring node networking (integer value)
# from .timeouts.drydock_provisioner.apply_node_networking
{{ if not .timeouts.drydock_provisioner.apply_node_networking }}#{{ end }}apply_node_networking = {{ .timeouts.drydock_provisioner.apply_node_networking | default "5" }}

# Timeout in minutes for deploying a node (integer value)
# from .timeouts.drydock_provisioner.deploy_node
{{ if not .timeouts.drydock_provisioner.deploy_node }}#{{ end }}deploy_node = {{ .timeouts.drydock_provisioner.deploy_node | default "45" }}

{{- end -}}
