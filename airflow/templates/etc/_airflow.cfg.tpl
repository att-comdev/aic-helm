[core]
# The home folder for airflow, default is ~/airflow
airflow_home = {{ .Values.conf.core.airflow_home }}

# The folder where your airflow pipelines live, most likely a
# subfolder in a code repository
dags_folder = {{ .Values.conf.core.dags_folder }}

# The folder where airflow should store its log files. This location
base_log_folder =  {{ .Values.conf.core.base_log_folder }}

# Airflow can store logs remotely in AWS S3 or Google Cloud Storage. Users
# must supply a remote location URL (starting with either 's3://...' or
# 'gs://...') and an Airflow connection id that provides access to the storage
# location.
remote_base_log_folder = {{ .Values.conf.core.remote_base_log_folder }}
remote_log_conn_id = {{ .Values.conf.core.remote_log_conn_id }}
# Use server-side encryption for logs stored in S3
encrypt_s3_logs = {{ .Values.conf.core.encrypt_s3_logs }} 
# deprecated option for remote log storage, use remote_base_log_folder instead!
# s3_log_folder =

# The executor class that airflow should use. Choices include
# SequentialExecutor, LocalExecutor, CeleryExecutor
executor = {{ .Values.conf.core.executor }}

# The SqlAlchemy connection string to the metadata database.
# SqlAlchemy supports many different database engine, more information
# their website
sql_alchemy_conn = {{ tuple "postgresql" "internal" "user" "postgresql" . | include "helper.authenticated_endpoint_uri_lookup" }}

# The SqlAlchemy pool size is the maximum number of database connections
# in the pool.
sql_alchemy_pool_size = {{ .Values.conf.core.sql_alchemy_pool_size }}

# The SqlAlchemy pool recycle is the number of seconds a connection
# can be idle in the pool before it is invalidated. This config does
# not apply to sqlite.
sql_alchemy_pool_recycle = {{ .Values.conf.core.sql_alchemy_pool_recycle }}

# The amount of parallelism as a setting to the executor. This defines
# the max number of task instances that should run simultaneously
# on this airflow installation
parallelism = {{ .Values.conf.core.parallelism }}

# The number of task instances allowed to run concurrently by the scheduler
dag_concurrency = {{ .Values.conf.core.dag_concurrency }}

# Are DAGs paused by default at creation
dags_are_paused_at_creation = {{ .Values.conf.core.dags_are_paused_at_creation }}

# The maximum number of active DAG runs per DAG
max_active_runs_per_dag = {{ .Values.conf.core.max_active_runs_per_dag }}

# Whether to load the examples that ship with Airflow. It's good to
# get started, but you probably want to set this to False in a production
# environment
load_examples = {{ .Values.conf.core.load_examples }}

# Where your Airflow plugins are stored
plugins_folder = {{ .Values.conf.core.plugins_folder }}

# Secret key to save connection passwords in the db
fernet_key = {{ .Values.conf.core.fernet_key }}

# Whether to disable pickling dags
donot_pickle = {{ .Values.conf.core.donot_pickle }}

# How long before timing out a python file import while filling the DagBag
dagbag_import_timeout = {{ .Values.conf.core.dagbag_import_timeout }}

[webserver]
# The base url of your website as airflow cannot guess what domain or
# cname you are using. This is use in automated emails that
# airflow sends to point links to the right web server
base_url = {{ .Values.conf.webserver.base_url }}

# The ip specified when starting the web server
web_server_host = {{ .Values.conf.webserver.web_server_host }}

# The port on which to run the web server
web_server_port = {{ .Values.conf.webserver.web_server_port }}

# The time the gunicorn webserver waits before timing out on a worker
web_server_worker_timeout = {{ .Values.conf.webserver.web_server_worker_timeout }}

# Secret key used to run your flask app
secret_key = {{ .Values.conf.webserver.secret_key }}

# Number of workers to run the Gunicorn web server
workers = {{ .Values.conf.webserver.workers }}

# The worker class gunicorn should use. Choices include
# sync (default), eventlet, gevent
worker_class = {{ .Values.conf.webserver.worker_class }}

# Expose the configuration file in the web server
expose_config = {{ .Values.conf.webserver.expose_config }}

# Set to true to turn on authentication : http://pythonhosted.org/airflow/installation.html#web-authentication
authenticate = {{ .Values.conf.webserver.authenticate }}

# Filter the list of dags by owner name (requires authentication to be enabled)
filter_by_owner = {{ .Values.conf.webserver.filter_by_owner }}

[email]
email_backend = {{ .Values.conf.email.email_backend }}

[smtp]
# If you want airflow to send emails on retries, failure, and you want to
# the airflow.utils.send_email function, you have to configure an smtp
# server here
smtp_host = {{ .Values.conf.smtp.smtp_host }}
smtp_starttls = {{ .Values.conf.smtp.smtp_starttls }}
smtp_ssl = {{ .Values.conf.smtp.smtp_ssl }}
smtp_user = {{ .Values.conf.smtp.smtp_user }}
smtp_port = {{ .Values.conf.smtp.smtp_port }}
smtp_password = {{ .Values.conf.smtp.smtp_password }}
smtp_mail_from = {{ .Values.conf.smtp.smtp_mail_from }}

[celery]
# This section only applies if you are using the CeleryExecutor in
# [core] section above

# The app name that will be used by celery
celery_app_name = {{ .Values.conf.celery.celery_app_name }}

# The concurrency that will be used when starting workers with the
# "airflow worker" command. This defines the number of task instances that
# a worker will take, so size up your workers based on the resources on
# your worker box and the nature of your tasks
celeryd_concurrency = {{ .Values.conf.celery.celeryd_concurrency }}

# When you start an airflow worker, airflow starts a tiny web server
# subprocess to serve the workers local log files to the airflow main
# web server, who then builds pages and sends them to users. This defines
# the port on which the logs are served. It needs to be unused, and open
# visible from the main web server to connect into the workers.
worker_log_server_port = {{ .Values.conf.celery.worker_log_server_port }}

# The Celery broker URL. Celery supports RabbitMQ, Redis and experimentally
# a sqlalchemy database. Refer to the Celery documentation for more
# information.
broker_url = {{ tuple "postgresql" "internal" "user" "amqp" . | include "helper.authenticated_endpoint_uri_lookup" }}

# Another key Celery setting
celery_result_backend = {{ tuple "postgresql" "internal" "user" "amqp" . | include "helper.authenticated_endpoint_uri_lookup" }}

# Celery Flower is a sweet UI for Celery. Airflow has a shortcut to start
# it `airflow flower`. This defines the port that Celery Flower runs on
flower_port = {{ .Values.conf.celery.flower_port }}

# Default queue that tasks get assigned to and that worker listen on.
default_queue = {{ .Values.conf.celery.default_queue }}

[scheduler]
# Task instances listen for external kill signal (when you clear tasks
# from the CLI or the UI), this defines the frequency at which they should
# listen (in seconds).
job_heartbeat_sec = {{ .Values.conf.scheduler.job_heartbeat_sec }}

# The scheduler constantly tries to trigger new tasks (look at the
# scheduler section in the docs for more information). This defines
# how often the scheduler should run (in seconds).
scheduler_heartbeat_sec = {{ .Values.conf.scheduler.scheduler_heartbeat_sec }}

# Statsd (https://github.com/etsy/statsd) integration settings
# statsd_on =  False
# statsd_host =  localhost
# statsd_port =  8125
# statsd_prefix = airflow

# The scheduler can run multiple threads in parallel to schedule dags.
# This defines how many threads will run. However airflow will never
# use more threads than the amount of cpu cores available.
max_threads = {{ .Values.conf.scheduler.max_threads }}

[mesos]
# Mesos master address which MesosExecutor will connect to.
master = {{ .Values.conf.mesos.master }}

# The framework name which Airflow scheduler will register itself as on mesos
framework_name = {{ .Values.conf.mesos.framework_name }}

# Number of cpu cores required for running one task instance using
# 'airflow run <dag_id> <task_id> <execution_date> --local -p <pickle_id>'
# command on a mesos slave
task_cpu = {{ .Values.conf.mesos.task_cpu }}

# Memory in MB required for running one task instance using
# 'airflow run <dag_id> <task_id> <execution_date> --local -p <pickle_id>'
# command on a mesos slave
task_memory = {{ .Values.conf.mesos.task_memory }}

# Enable framework checkpointing for mesos
# See http://mesos.apache.org/documentation/latest/slave-recovery/
checkpoint = {{ .Values.conf.mesos.checkpoint }}

# Failover timeout in milliseconds.
# When checkpointing is enabled and this option is set, Mesos waits
# until the configured timeout for
# the MesosExecutor framework to re-register after a failover. Mesos
# shuts down running tasks if the
# MesosExecutor framework fails to re-register within this timeframe.
# failover_timeout = 604800

# Enable framework authentication for mesos
# See http://mesos.apache.org/documentation/latest/configuration/
authenticate = {{ .Values.conf.mesos.authenticate }}

# Mesos credentials, if authentication is enabled
# default_principal = admin
# default_secret = admin
