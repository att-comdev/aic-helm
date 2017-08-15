{{ include "airflow.cfg.airflow_values_skeleton" .Values.conf.airflow | trunc 0 }}
{{ include "airflow.cfg.airflow" .Values.conf.airflow}}

{{- define "airflow.cfg.airflow_values_skeleton" -}}

{{- if not .default -}}{{- set . "default" dict -}}{{- end -}}
{{- if not .default.core -}}{{- set .default "core" dict -}}{{- end -}}
{{- if not .default.webserver -}}{{- set .default "webserver" dict -}}{{- end -}}
{{- if not .default.email -}}{{- set .default "email" dict -}}{{- end -}}
{{- if not .default.smtp -}}{{- set .default "smtp" dict -}}{{- end -}}
{{- if not .default.celery -}}{{- set .default "celery" dict -}}{{- end -}}
{{- if not .default.scheduler -}}{{- set .default "scheduler" dict -}}{{- end -}}
{{- if not .default.mesos -}}{{- set .default "mesos" dict -}}{{- end -}}

{{- end -}}

{{- define "airflow.cfg.airflow" -}}

[core]
# The home folder for airflow, default is ~/airflow
{{ if not .default.core.airflow_home }}#{{ end }}airflow_home = {{ .default.core.airflow_home | default "/usr/local/airflow" }}

# The folder where your airflow pipelines live, most likely a
# subfolder in a code repository
{{ if not .default.core.dags_folder }}#{{ end }}dags_folder = {{ .default.core.dags_folder | default "/usr/local/airflow/dags" }}

# The folder where airflow should store its log files. This location
{{ if not .default.core.base_log_folder }}#{{ end }}base_log_folder = {{ .default.core.base_log_folder | default "/usr/local/airflow/logs" }}

# Airflow can store logs remotely in AWS S3 or Google Cloud Storage. Users
# must supply a remote location URL (starting with either 's3://...' or
# 'gs://...') and an Airflow connection id that provides access to the storage
# location.
{{ if not .default.core.remote_base_log_folder }}#{{ end }}remote_base_log_folder = {{ .default.core.remote_base_log_folder | default "" }}
{{ if not .default.core.remote_log_conn_id }}#{{ end }}remote_log_conn_id = {{ .default.core.remote_log_conn_id | default "" }}
# Use server-side encryption for logs stored in S3
encrypt_s3_logs = {{ .default.core.encrypt_s3_logs | default "False" }}
# deprecated option for remote log storage, use remote_base_log_folder instead!
# s3_log_folder =

# The executor class that airflow should use. Choices include
# SequentialExecutor, LocalExecutor, CeleryExecutor
{{ if not .default.core.executor }}#{{ end }}executor = {{ .default.core.executor | default "CeleryExecutor" }}

# The SqlAlchemy connection string to the metadata database.
# SqlAlchemy supports many different database engine, more information
# their website
{{ if not .default.core.sql_alchemy_conn }}#{{ end }}sql_alchemy_conn = {{ .default.core.sql_alchemy_conn | default "postgresql+psycopg2://airflow:airflow@postgresql/" }}

# The SqlAlchemy pool size is the maximum number of database connections
# in the pool.
{{ if not .default.core.sql_alchemy_pool_size }}#{{ end }}sql_alchemy_pool_size = {{ .default.core.sql_alchemy_pool_size | default "5" }}

# The SqlAlchemy pool recycle is the number of seconds a connection
# can be idle in the pool before it is invalidated. This config does
# not apply to sqlite.
{{ if not .default.core.sql_alchemy_pool_recycle }}#{{ end }}sql_alchemy_pool_recycle = {{ .default.core.sql_alchemy_pool_recycle | default "3600" }}

# The amount of parallelism as a setting to the executor. This defines
# the max number of task instances that should run simultaneously
# on this airflow installation
{{ if not .default.core.parallelism }}#{{ end }}parallelism = {{ .default.core.parallelism | default "32" }}

# The number of task instances allowed to run concurrently by the scheduler
{{ if not .default.core.dag_concurrency }}#{{ end }}dag_concurrency = {{ .default.core.dag_concurrency | default "16" }}

# Are DAGs paused by default at creation
dags_are_paused_at_creation = {{ .default.core.dags_are_paused_at_creation | default "False" }}

# When not using pools, tasks are run in the "default pool",
# whose size is guided by this config element
{{ if not .default.core.non_pooled_task_slot_count }}#{{ end }}non_pooled_task_slot_count = {{ .default.core.non_pooled_task_slot_count | default "128" }}

# The maximum number of active DAG runs per DAG
{{ if not .default.core.max_active_runs_per_dag }}#{{ end }}max_active_runs_per_dag = {{ .default.core.max_active_runs_per_dag | default "16" }}

# Whether to load the examples that ship with Airflow. It's good to
# get started, but you probably want to set this to False in a production
# environment
load_examples = {{ .default.core.load_examples | default "False" }}

# Where your Airflow plugins are stored
{{ if not .default.core.plugins_folder }}#{{ end }}plugins_folder = {{ .default.core.plugins_folder | default "/usr/local/airflow/plugins" }}

# Secret key to save connection passwords in the db
{{ if not .default.core.fernet_key }}#{{ end }}fernet_key = {{ .default.core.fernet_key | default "fKp7omMJ4QlTxfZzVBSiyXVgeCK-6epRjGgMpEIsjvs=" }}

# Whether to disable pickling dags
donot_pickle = {{ .default.core.donot_pickle | default "False" }}

# How long before timing out a python file import while filling the DagBag
{{ if not .default.core.dagbag_import_timeout }}#{{ end }}dagbag_import_timeout = {{ .default.core.dagbag_import_timeout | default "30" }}

# The class to use for running task instances in a subprocess
{{ if not .default.core.task_runner }}#{{ end }}task_runner = {{ .default.core.task_runner | default "BashTaskRunner" }}

# If set, tasks without a `run_as_user` argument will be run with this user
# Can be used to de-elevate a sudo user running Airflow when executing tasks
{{ if not .default.core.default_impersonation }}#{{ end }}default_impersonation = {{ .default.core.default_impersonation | default "" }}

# What security module to use (for example kerberos):
{{ if not .default.core.security }}#{{ end }}security = {{ .default.core.security | default "" }}

# Turn unit test mode on (overwrites many configuration options with test
# values at runtime)
unit_test_mode = {{ .default.core.unit_test_mode | default "False" }}

[cli]
# In what way should the cli access the API. The LocalClient will use the
# database directly, while the json_client will use the api running on the
# webserver
{{ if not .default.cli.api_client }}#{{ end }}api_client = {{ .default.cli.api_client | default "airflow.api.client.local_client" }}
{{ if not .default.cli.endpoint_url }}#{{ end }}endpoint_url = {{ .default.cli.endpoint_url | default "http://web.shipyard:8080" }}

[api]
# How to authenticate users of the API
{{ if not .default.api.auth_backend }}#{{ end }}auth_backend = {{ .default.api.auth_backend | default "airflow.api.auth.backend.default" }}

[operators]
# The default owner assigned to each new operator, unless
# provided explicitly or passed via `default_args`
{{ if not .default.operators.default_owner }}#{{ end }}default_owner = {{ .default.operators.default_owner | default "Airflow" }}
{{ if not .default.operators.default_cpus }}#{{ end }}default_cpus = {{ .default.operators.default_cpus | default "1" }}
{{ if not .default.operators.default_ram }}#{{ end }}default_ram = {{ .default.operators.default_ram | default "512" }}
{{ if not .default.operators.default_disk }}#{{ end }}default_disk = {{ .default.operators.default_disk | default "512" }}
{{ if not .default.operators.default_gpus }}#{{ end }}default_gpus = {{ .default.operators.default_gpus | default "0" }}

[webserver]
# The base url of your website as airflow cannot guess what domain or
# cname you are using. This is use in automated emails that
# airflow sends to point links to the right web server
{{ if not .default.webserver.base_url }}#{{ end }}base_url = {{ .default.webserver.base_url | default "http://web.shipyard:8080" }}

# The ip specified when starting the web server
{{ if not .default.webserver.web_server_host }}#{{ end }}web_server_host = {{ .default.webserver.web_server_host | default "0.0.0.0" }}

# The port on which to run the web server
{{ if not .default.webserver.web_server_port }}#{{ end }}web_server_port = {{ .default.webserver.web_server_port | default "8080" }}

# Paths to the SSL certificate and key for the web server. When both are
# provided SSL will be enabled. This does not change the web server port.
{{ if not .default.webserver.web_server_ssl_cert }}#{{ end }}web_server_ssl_cert = {{ .default.webserver.web_server_ssl_cert | default "" }}
{{ if not .default.webserver.web_server_ssl_key }}#{{ end }}web_server_ssl_key = {{ .default.webserver.web_server_ssl_key | default "" }}

# The time the gunicorn webserver waits before timing out on a worker
{{ if not .default.webserver.web_server_worker_timeout }}#{{ end }}web_server_worker_timeout = {{ .default.webserver.web_server_worker_timeout | default "120" }}

# Number of workers to refresh at a time. When set to 0, worker refresh is
# disabled. When nonzero, airflow periodically refreshes webserver workers by
# bringing up new ones and killing old ones.
{{ if not .default.webserver.worker_refresh_batch_size }}#{{ end }}worker_refresh_batch_size = {{ .default.webserver.worker_refresh_batch_size | default "1" }}

# Number of seconds to wait before refreshing a batch of workers.
{{ if not .default.webserver.worker_refresh_interval }}#{{ end }}worker_refresh_interval = {{ .default.webserver.worker_refresh_interval | default "30" }}

# Secret key used to run your flask app
{{ if not .default.webserver.secret_key }}#{{ end }}secret_key = {{ .default.webserver.secret_key | default "temporary_key" }}

# Number of workers to run the Gunicorn web server
{{ if not .default.webserver.workers }}#{{ end }}workers = {{ .default.webserver.workers | default "4" }}

# The worker class gunicorn should use. Choices include
# sync (default), eventlet, gevent
{{ if not .default.webserver.worker_class }}#{{ end }}worker_class = {{ .default.webserver.worker_class | default "sync" }}

# Log files for the gunicorn webserver. '-' means log to stderr.
{{ if not .default.webserver.access_logfile }}#{{ end }}access_logfile = {{ .default.webserver.access_logfile | default "-" }}
{{ if not .default.webserver.error_logfile }}#{{ end }}error_logfile = {{ .default.webserver.error_logfile | default "-" }}

# Expose the configuration file in the web server
{{ if not .default.webserver.expose_config }}#{{ end }}expose_config = {{ .default.webserver.expose_config | default "true" }}

# Set to true to turn on authentication : http://pythonhosted.org/airflow/installation.html#web-authentication
authenticate = {{ .default.webserver.authenticate | default "False" }}

# Filter the list of dags by owner name (requires authentication to be enabled)
filter_by_owner = {{ .default.webserver.filter_by_owner | default "False" }}

# Filtering mode. Choices include user (default) and ldapgroup.
# Ldap group filtering requires using the ldap backend
#
# Note that the ldap server needs the "memberOf" overlay to be set up
# in order to user the ldapgroup mode.
{{ if not .default.webserver.owner_mode }}#{{ end }}owner_mode = {{ .default.webserver.owner_mode | default "user" }}

# Default DAG orientation. Valid values are:
# LR (Left->Right), TB (Top->Bottom), RL (Right->Left), BT (Bottom->Top)
{{ if not .default.webserver.dag_orientation }}#{{ end }}dag_orientation = {{ .default.webserver.dag_orientation | default "LR" }}

# Puts the webserver in demonstration mode; blurs the names of Operators for
# privacy.
demo_mode = {{ .default.webserver.demo_mode | default "False" }}

# The amount of time (in secs) webserver will wait for initial handshake
# while fetching logs from other worker machine
{{ if not .default.webserver.log_fetch_timeout_sec }}#{{ end }}log_fetch_timeout_sec = {{ .default.webserver.log_fetch_timeout_sec | default "5" }}

# By default, the webserver shows paused DAGs. Flip this to hide paused
# DAGs by default
hide_paused_dags_by_default = {{ .default.webserver.hide_paused_dags_by_default | default "False" }}

[email]
{{ if not .default.email.email_backend }}#{{ end }}email_backend = {{ .default.email.email_backend | default "airflow.utils.send_email_smtp" }}

[smtp]
# If you want airflow to send emails on retries, failure, and you want to
# the airflow.utils.send_email function, you have to configure an smtp
# server here
{{ if not .default.smtp.smtp_host }}#{{ end }}smtp_host = {{ .default.smtp.smtp_host | default "localhost" }}
{{ if not .default.smtp.smtp_starttls }}#{{ end }}smtp_smtp_starttls = {{ .default.smtp.smtp_starttls | default "True" }}
smtp_ssl = {{ .default.smtp.smtp_ssl | default "False" }}
{{ if not .default.smtp.smtp_user }}#{{ end }}smtp_user = {{ .default.smtp.smtp_user | default "airflow" }}
{{ if not .default.smtp.smtp_port }}#{{ end }}smtp_port = {{ .default.smtp.smtp_port | default "25" }}
{{ if not .default.smtp.smtp_password }}#{{ end }}smtp_password = {{ .default.smtp.smtp_password | default "airflow" }}
{{ if not .default.smtp.smtp_mail_from }}#{{ end }}smtp_mail_from = {{ .default.smtp.smtp_mail_from | default "airflow@airflow.local" }}

[celery]
# This section only applies if you are using the CeleryExecutor in
# [core] section above

# The app name that will be used by celery
{{ if not .default.celery.celery_app_name }}#{{ end }}celery_app_name = {{ .default.celery.celery_app_name | default "airflow.executors.celery_executor" }}

# The concurrency that will be used when starting workers with the
# "airflow worker" command. This defines the number of task instances that
# a worker will take, so size up your workers based on the resources on
# your worker box and the nature of your tasks
{{ if not .default.celery.celeryd_concurrency }}#{{ end }}celeryd_concurrency = {{ .default.celery.celeryd_concurrency | default "16" }}

# When you start an airflow worker, airflow starts a tiny web server
# subprocess to serve the workers local log files to the airflow main
# web server, who then builds pages and sends them to users. This defines
# the port on which the logs are served. It needs to be unused, and open
# visible from the main web server to connect into the workers.
{{ if not .default.celery.worker_log_server_port }}#{{ end }}worker_log_server_port = {{ .default.celery.worker_log_server_port | default "8793" }}

# The Celery broker URL. Celery supports RabbitMQ, Redis and experimentally
# a sqlalchemy database. Refer to the Celery documentation for more
# information.
{{ if not .default.celery.broker_url }}#{{ end }}broker_url = {{ .default.celery.broker_url | default "amqp://airflow:airflow@rabbitmq:5672/" }}

# Another key Celery setting
{{ if not .default.celery.celery_result_backend }}#{{ end }}celery_result_backend = {{ .default.celery.celery_result_backend | default "amqp://airflow:airflow@rabbitmq:5672/" }}

# Celery Flower is a sweet UI for Celery. Airflow has a shortcut to start
# it `airflow flower`. This defines the IP that Celery Flower runs on
{{ if not .default.celery.flower_host }}#{{ end }}flower_host = {{ .default.celery.flower_host | default "0.0.0.0" }}

# This defines the port that Celery Flower runs on
{{ if not .default.celery.flower_port }}#{{ end }}flower_port = {{ .default.celery.flower_port | default "5555" }}

# Default queue that tasks get assigned to and that worker listen on.
{{ if not .default.celery.default_queue }}#{{ end }}default_queue = {{ .default.celery.default_queue | default "default" }}

[scheduler]
# Task instances listen for external kill signal (when you clear tasks
# from the CLI or the UI), this defines the frequency at which they should
# listen (in seconds).
{{ if not .default.scheduler.job_heartbeat_sec }}#{{ end }}job_heartbeat_sec = {{ .default.scheduler.job_heartbeat_sec | default "5" }}

# The scheduler constantly tries to trigger new tasks (look at the
# scheduler section in the docs for more information). This defines
# how often the scheduler should run (in seconds).
{{ if not .default.scheduler.scheduler_heartbeat_sec }}#{{ end }}scheduler_heartbeat_sec = {{ .default.scheduler.scheduler_heartbeat_sec | default "5" }}

# after how much time should the scheduler terminate in seconds
# -1 indicates to run continuously (see also num_runs)
{{ if not .default.scheduler.run_duration }}#{{ end }}run_duration = {{ .default.scheduler.run_duration | default "-1" }}

# after how much time a new DAGs should be picked up from the filesystem
{{ if not .default.scheduler.min_file_process_interval }}#{{ end }}min_file_process_interval = {{ .default.scheduler.min_file_process_interval | default "0" }}

{{ if not .default.scheduler.dag_dir_list_interval }}#{{ end }}dag_dir_list_interval = {{ .default.scheduler.dag_dir_list_interval | default "300" }}

# How often should stats be printed to the logs
{{ if not .default.scheduler.print_stats_interval }}#{{ end }}print_stats_interval = {{ .default.scheduler.print_stats_interval | default "30" }}

{{ if not .default.scheduler.child_process_log_directory }}#{{ end }}child_process_log_directory = {{ .default.scheduler.child_process_log_directory | default "/usr/local/airflow/logs/scheduler" }}

# Local task jobs periodically heartbeat to the DB. If the job has
# not heartbeat in this many seconds, the scheduler will mark the
# associated task instance as failed and will re-schedule the task.
{{ if not .default.scheduler.scheduler_zombie_task_threshold }}#{{ end }}scheduler_zombie_task_threshold = {{ .default.scheduler.scheduler_zombie_task_threshold | default "300" }}

# Turn off scheduler catchup by setting this to False.
# Default behavior is unchanged and
# Command Line Backfills still work, but the scheduler
# will not do scheduler catchup if this is False,
# however it can be set on a per DAG basis in the
# DAG definition (catchup)
{{ if not .default.scheduler.catchup_by_default }}#{{ end }}catchup_by_default = {{ .default.scheduler.catchup_by_default | default "True" }}

# Statsd (https://github.com/etsy/statsd) integration settings
# statsd_on = False
# statsd_host = localhost
# statsd_port = 8125
# statsd_prefix = airflow

# The scheduler can run multiple threads in parallel to schedule dags.
# This defines how many threads will run. However airflow will never
# use more threads than the amount of cpu cores available.
{{ if not .default.scheduler.max_threads }}#{{ end }}max_threads = {{ .default.scheduler.max_threads | default "2" }}

authenticate = {{ .default.scheduler.authenticate | default "False" }}

[mesos]
# Mesos master address which MesosExecutor will connect to.
{{ if not .default.mesos.master }}#{{ end }}master = {{ .default.mesos.master | default "localhost:5050" }}

# The framework name which Airflow scheduler will register itself as on mesos
{{ if not .default.mesos.framework_name }}#{{ end }}framework_name = {{ .default.mesos.framework_name | default "Airflow" }}

# Number of cpu cores required for running one task instance using
# 'airflow run <dag_id> <task_id> <execution_date> --local -p <pickle_id>'
# command on a mesos slave
{{ if not .default.mesos.task_cpu }}#{{ end }}task_cpu = {{ .default.mesos.task_cpu | default "1" }}

# Memory in MB required for running one task instance using
# 'airflow run <dag_id> <task_id> <execution_date> --local -p <pickle_id>'
# command on a mesos slave
{{ if not .default.mesos.task_memory }}#{{ end }}task_memory = {{ .default.mesos.task_memory | default "256" }}

# Enable framework checkpointing for mesos
# See http://mesos.apache.org/documentation/latest/slave-recovery/
checkpoint = {{ .default.mesos.checkpoint | default "False" }}

# Failover timeout in milliseconds.
# When checkpointing is enabled and this option is set, Mesos waits
# until the configured timeout for
# the MesosExecutor framework to re-register after a failover. Mesos
# shuts down running tasks if the
# MesosExecutor framework fails to re-register within this timeframe.
# failover_timeout = 604800

# Enable framework authentication for mesos
# See http://mesos.apache.org/documentation/latest/configuration/
authenticate = {{ .default.mesos.authenticate | default "False" }}

# Mesos credentials, if authentication is enabled
# default_principal = admin
# default_secret = admin

[kerberos]
#ccache = /tmp/airflow_krb5_ccache
# gets augmented with fqdn
#principal = airflow
#reinit_frequency = 3600
#kinit_path = kinit
#keytab = airflow.keytab

[github_enterprise]
#api_rev = v3

[admin]
# UI to hide sensitive variable fields when set to True
{{ if not .default.admin.hide_sensitive_variable_fields }}#{{ end }}hide_sensitive_variable_fields = {{ .default.admin.hide_sensitive_variable_fields | default "True" }}

{{- end -}}

