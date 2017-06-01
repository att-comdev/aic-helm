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
{{ if not .default.core.encrypt_s3_logs }}#{{ end }}encrypt_s3_logs = {{ .default.core.encrypt_s3_logs | default "False" }}
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
{{ if not .default.core.dags_are_paused_at_creation }}#{{ end }}dags_are_paused_at_creation = {{ .default.core.dags_are_paused_at_creation | default "False" }}

# The maximum number of active DAG runs per DAG
{{ if not .default.core.max_active_runs_per_dag }}#{{ end }}max_active_runs_per_dag = {{ .default.core.max_active_runs_per_dag | default "16" }}

# Whether to load the examples that ship with Airflow. It's good to
# get started, but you probably want to set this to False in a production
# environment
{{ if not .default.core.load_examples }}#{{ end }}load_examples = {{ .default.core.load_examples | default "False" }}

# Where your Airflow plugins are stored
{{ if not .default.core.plugins_folder }}#{{ end }}plugins_folder = {{ .default.core.plugins_folder | default "/usr/local/airflow/plugins" }}

# Secret key to save connection passwords in the db
{{ if not .default.core.fernet_key }}#{{ end }}fernet_key = {{ .default.core.fernet_key | default "fKp7omMJ4QlTxfZzVBSiyXVgeCK-6epRjGgMpEIsjvs=" }}

# Whether to disable pickling dags
{{ if not .default.core.donot_pickle }}#{{ end }}donot_pickle = {{ .default.core.donot_pickle | default "False" }}

# How long before timing out a python file import while filling the DagBag
{{ if not .default.core.dagbag_import_timeout }}#{{ end }}dagbag_import_timeout = {{ .default.core.dagbag_import_timeout | default "30" }}

[webserver]
# The base url of your website as airflow cannot guess what domain or
# cname you are using. This is use in automated emails that
# airflow sends to point links to the right web server
{{ if not .default.webserver.base_url }}#{{ end }}base_url = {{ .default.webserver.base_url | default "http://web.airflow:8080" }}

# The ip specified when starting the web server
{{ if not .default.webserver.web_server_host }}#{{ end }}web_server_host = {{ .default.webserver.web_server_host | default "0.0.0.0" }}

# The port on which to run the web server
{{ if not .default.webserver.web_server_port }}#{{ end }}web_server_port = {{ .default.webserver.web_server_port | default "8080" }}

# The time the gunicorn webserver waits before timing out on a worker
{{ if not .default.webserver.web_server_worker_timeout }}#{{ end }}web_server_worker_timeout = {{ .default.webserver.web_server_worker_timeout | default "120" }}

# Secret key used to run your flask app
{{ if not .default.webserver.secret_key }}#{{ end }}secret_key = {{ .default.webserver.secret_key | default "temporary_key" }}

# Number of workers to run the Gunicorn web server
{{ if not .default.webserver.workers }}#{{ end }}workers = {{ .default.webserver.workers | default "4" }}

# The worker class gunicorn should use. Choices include
# sync (default), eventlet, gevent
{{ if not .default.webserver.worker_class }}#{{ end }}worker_class = {{ .default.webserver.worker_class | default "sync" }}

# Expose the configuration file in the web server
{{ if not .default.webserver.expose_config }}#{{ end }}expose_config = {{ .default.webserver.expose_config | default "true" }}

# Set to true to turn on authentication : http://pythonhosted.org/airflow/installation.html#web-authentication
{{ if not .default.webserver.authenticate }}#{{ end }}authenticate = {{ .default.webserver.authenticate | default "False" }}

# Filter the list of dags by owner name (requires authentication to be enabled)
{{ if not .default.webserver.filter_by_owner }}#{{ end }}filter_by_owner = {{ .default.webserver.filter_by_owner | default "False" }}

[email]
{{ if not .default.email.email_backend }}#{{ end }}email_backend = {{ .default.email.email_backend | default "airflow.utils.send_email_smtp" }}

[smtp]
# If you want airflow to send emails on retries, failure, and you want to
# the airflow.utils.send_email function, you have to configure an smtp
# server here
{{ if not .default.smtp.smtp_host }}#{{ end }}smtp_host = {{ .default.smtp.smtp_host | default "localhost" }}
{{ if not .default.smtp.smtp_starttls }}#{{ end }}smtp_host = {{ .default.smtp.smtp_starttls | default "True" }}
{{ if not .default.smtp.smtp_ssl }}#{{ end }}smtp_ssl = {{ .default.smtp.smtp_ssl | default "False" }}
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
# it `airflow flower`. This defines the port that Celery Flower runs on
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

# Statsd (https://github.com/etsy/statsd) integration settings
# statsd_on =  False
# statsd_host =  localhost
# statsd_port =  8125
# statsd_prefix = airflow

# The scheduler can run multiple threads in parallel to schedule dags.
# This defines how many threads will run. However airflow will never
# use more threads than the amount of cpu cores available.
{{ if not .default.scheduler.max_threads }}#{{ end }}max_threads = {{ .default.scheduler.max_threads | default "2" }}

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
{{ if not .default.mesos.checkpoint }}#{{ end }}checkpoint = {{ .default.mesos.checkpoint | default "False" }}

# Failover timeout in milliseconds.
# When checkpointing is enabled and this option is set, Mesos waits
# until the configured timeout for
# the MesosExecutor framework to re-register after a failover. Mesos
# shuts down running tasks if the
# MesosExecutor framework fails to re-register within this timeframe.
# failover_timeout = 604800

# Enable framework authentication for mesos
# See http://mesos.apache.org/documentation/latest/configuration/
{{ if not .default.mesos.authenticate }}#{{ end }}authenticate = {{ .default.mesos.authenticate | default "False" }}

# Mesos credentials, if authentication is enabled
# default_principal = admin
# default_secret = admin

{{- end -}}
