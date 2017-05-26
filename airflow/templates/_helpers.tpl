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

#-----------------------------------------
# endpoints
#-----------------------------------------
# this function helps resolve database style endpoints, which really follow the same
# pattern as above, except they have a username and password component
#
# presuming that .Values contains an endpoint: definition for 'neutron-db' with the
# appropriate attributes, a call such as:
#
# { tuple "neutron-db" "internal" "userClass" "portName" . | include "helper.authenticated_endpoint_uri_lookup" }
#
# where portName is optional if a default port has been defined in .Values
#
# returns: mysql+pymysql://username:password@internal_host:3306/dbname

{{- define "helper.authenticated_endpoint_uri_lookup" -}}
{{- $type := index . 0 -}}
{{- $endpoint := index . 1 -}}
{{- $userclass := index . 2 -}}
{{- $port := index . 3 -}}
{{- $context := index . 4 -}}
{{- $endpointMap := index $context.Values.endpoints $type }}
{{- $userMap := index $endpointMap.auth $userclass }}
{{- $fqdn := $context.Release.Namespace -}}
{{- if $context.Values.endpoints.fqdn -}}
{{- $fqdn := $context.Values.endpoints.fqdn -}}
{{- end -}}
{{- with $endpointMap -}}
{{- $endpointScheme := .scheme }}
{{- $endpointUser := index $userMap "username" }}
{{- $endpointPass := index $userMap "password" }}
{{- $endpointHost := index .hosts $endpoint | default .hosts.default}}
{{- $endpointPort := index .port $port | default .port.default }}
{{- $endpointPath := .path | default "" }}
{{- printf "%s://%s:%s@%s.%s:%1.f%s" $endpointScheme $endpointUser $endpointPass $endpointHost $fqdn $endpointPort $endpointPath -}}
{{- end -}}
{{- end -}}


#-----------------------------------------
# Functions
#-----------------------------------------
{{- define "helper.joinListWithComma" -}}
{{ range $k, $v := . }}{{ if $k }},{{ end }}{{ $v }}{{ end }}
{{- end -}}

{{- define "helper.template" -}}
{{- $name := index . 0 -}}
{{- $context := index . 1 -}}
{{- $v:= $context.Template.Name | split "/" -}}
{{- $n := len $v -}}
{{- $last := sub $n 1 | printf "_%d" | index $v -}}
{{- $wtf := $context.Template.Name | replace $last $name -}}
{{ include $wtf $context }}
{{- end -}}


#-----------------------------------------
# Kubernetes Entry Init Container
#-----------------------------------------
{{- define "helper.kubernetes_entrypoint_init_container" -}}
{{- $envAll := index . 0 -}}
{{- $deps := index . 1 -}}
{
  "name": "init",
  "image": {{ $envAll.Values.images.dep_check | quote }},
  "imagePullPolicy": {{ $envAll.Values.images.pull_policy | quote }},
  "env": [
    {
      "name": "POD_NAME",
      {{- if $deps.pod -}}
      "value": "{{ index $deps.pod 0 }}"
      {{- else -}}
      "valueFrom": {
        "fieldRef": {
          "APIVersion": "v1",
          "fieldPath": "metadata.name"
        }
      }
      {{- end -}}
    },
    {
      "name": "NAMESPACE",
      "valueFrom": {
        "fieldRef": {
          "APIVersion": "v1",
          "fieldPath": "metadata.namespace"
        }
      }
    },
    {
      "name": "DEPENDENCY_SERVICE",
      "value": "{{  include "helper.joinListWithComma"  $deps.service }}"
    },
    {
      "name": "DEPENDENCY_JOBS",
      "value": "{{  include "helper.joinListWithComma" $deps.jobs }}"
    },
    {
      "name": "DEPENDENCY_DAEMONSET",
      "value": "{{  include "helper.joinListWithComma" $deps.daemonset }}"
    },
    {
      "name": "DEPENDENCY_CONTAINER",
      "value": "{{  include "helper.joinListWithComma" $deps.container }}"
    },
    {
      "name": "COMMAND",
      "value": "echo done"
    }
  ]
}
{{- end -}}

