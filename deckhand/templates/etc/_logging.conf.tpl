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

[loggers]
keys=root

[handlers]
keys=file,devel,syslog

[formatters]
keys=simple,tests

[logger_root]
level=DEBUG
handlers=file

[handler_file]
class=FileHandler
level=DEBUG
args=('deckhand.log', 'w+')
formatter=tests

[handler_syslog]
class=handlers.SysLogHandler
level=ERROR
args = ('/dev/log', handlers.SysLogHandler.LOG_USER)

[handler_devel]
class=StreamHandler
level=DEBUG
args=(sys.stdout,)
formatter=simple

[formatter_tests]
class = oslo_log.formatters.ContextFormatter

[formatter_simple]
format=%(asctime)s.%(msecs)03d %(process)d %(levelname)s: %(message)s
