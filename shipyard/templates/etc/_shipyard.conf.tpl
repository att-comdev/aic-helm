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

{{ include "shipyard.conf.shipyard_values_skeleton" .Values.conf.shipyard | trunc 0 }}
{{ include "shipyard.conf.shipyard" .Values.conf.shipyard }}

{{- define "shipyard.conf.shipyard_values_skeleton" -}}

{{- if not .default -}}{{- set . "default" dict -}}{{- end -}}
{{- if not .default.base -}}{{- set .default "base" dict -}}{{- end -}}

{{- end -}}


{{- define "shipyard.conf.shipyard" -}}


[base]
{{ if not .default.base.web_server }}#{{ end }}web_server = {{ .default.base.web_server | default "http://web.shipyard:8080" }}

{{- end -}}

