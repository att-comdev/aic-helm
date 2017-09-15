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

{{ include "logging.conf.logging_values_skeleton" .Values.conf.logging | trunc 0 }}
{{ include "logging.conf.logging" .Values.conf.logging }}

{{- define "logging.conf.logging_values_skeleton" -}}

{{- if not .loggers -}}{{- set . "loggers" dict -}}{{- end -}}
{{- if not .handlers -}}{{- set . "handlers" dict -}}{{- end -}}
{{- if not .formatters -}}{{- set . "formatters" dict -}}{{- end -}}
{{- if not .logger_root -}}{{- set . "logger_root" dict -}}{{- end -}}
{{- if not .handler_file -}}{{- set . "handler_file" dict -}}{{- end -}}
{{- if not .handler_syslog -}}{{- set . "handler_syslog" dict -}}{{- end -}}
{{- if not .handler_devel -}}{{- set . "handler_devel" dict -}}{{- end -}}
{{- if not .formatter_tests -}}{{- set . "formatter_tests" dict -}}{{- end -}}
{{- if not .formatter_simple -}}{{- set . "formatter_simple" dict -}}{{- end -}}

{{- end -}}

{{- define "logging.conf.logging" -}}

[loggers]
{{ if not .loggers.keys }}#{{ end }}keys = {{ .loggers.keys | default "root" }}

[handlers]
{{ if not .handlers.keys }}#{{ end }}keys = {{ .handlers.keys | default "file,devel,syslog" }}

[formatters]
{{ if not .formatters.keys }}#{{ end }}keys = {{ .formatters.keys | default "simple,tests" }}

[logger_root]
{{ if not .logger_root.level }}#{{ end }}level = {{ .logger_root.level | default "DEBUG" }}
{{ if not .logger_root.handlers }}#{{ end }}handlers = {{ .logger_root.handlers | default "file" }}

[handler_file]
{{ if not .handler_file.class }}#{{ end }}class = {{ .handler_file.class | default "FileHandler" }}
{{ if not .handler_file.level }}#{{ end }}level = {{ .handler_file.level | default "DEBUG" }}
{{ if not .handler_file.args }}#{{ end }}args = {{ .handler_file.args | default "('deckhand.log', 'w+')" }}
{{ if not .handler_file.formatter }}#{{ end }}formatter = {{ .handler_file.formatter | default "tests" }}

[handler_syslog]
{{ if not .handler_syslog.class }}#{{ end }}class = {{ .handler_syslog.class | default "handlers.SysLogHandler" }}
{{ if not .handler_syslog.level }}#{{ end }}level = {{ .handler_syslog.level | default "ERROR" }}
{{ if not .handler_syslog.args }}#{{ end }}args = {{ .handler_syslog.args | default "('/dev/log', handlers.SysLogHandler.LOG_USER)" }}

[handler_devel]
{{ if not .handler_devel.class }}#{{ end }}class = {{ .handler_devel.class | default "StreamHandler" }}
{{ if not .handler_devel.level }}#{{ end }}level = {{ .handler_devel.level | default "DEBUG" }}
{{ if not .handler_devel.args }}#{{ end }}args = {{ .handler_devel.args | default "(sys.stdout,)" }}
{{ if not .handler_devel.formatter }}#{{ end }}formatter = {{ .handler_devel.formatter | default "simple" }}

[formatter_tests]
{{ if not .formatter_tests.class }}#{{ end }}class = {{ .formatter_tests.class | default "oslo_log.formatters.ContextFormatter" }}

[formatter_simple]
{{ if not .formatter_simple.format }}#{{ end }}format = {{ .formatter_simple.format | default "%(asctime)s.%(msecs)03d %(process)d %(levelname)s: %(message)s" }}

{{- end -}}
