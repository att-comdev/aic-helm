## aic-helm/airflow ##

This chart installs airflow on kubernetes

### Quickstart ###

This chart requires a postgresql instance and rabbitmq to be running

Create airflow namespace:

```
kubectl create namespace airflow
```


To install postgresql:

```
helm install --name=airflow-postgresql postgresql --namespace=airflow
```

Note: Postgresql may take a short time to reach the 'Running' state. Verify that postgresql is running:

```
# kubectl get pods -n airflow
NAME                         READY     STATUS        RESTARTS   AGE
postgresql-0                 1/1       Running       0          1m
```


To install rabbitmq:

Go to the openstack-helm directory and execute the following commands:

```
helm install --name=airflow-etcd-rabbitmq local/etcd --namespace=airflow
helm install --name=airflow-rabbitmq local/rabbitmq --namespace=airflow
```

Note: We need to make sure that the etcd chart is executed before the rabbitmq chart due to dependencies

```
# kubectl get pods -n airflow
NAME                       READY     STATUS    RESTARTS   AGE
etcd-2810752095-054xb      1/1       Running   0          2m
postgresql-0               1/1       Running   0          3m
rabbitmq-646028817-0bwgp   1/1       Running   0          1m
rabbitmq-646028817-3hb1z   1/1       Running   0          1m
rabbitmq-646028817-sq6cw   1/1       Running   0          1m
```


To deploy airflow chart:

```
helm install --name=airflow airflow --namespace=airflow
```

To verify the airflow helm deployment was successful:

```
# kubectl get pods -n airflow
NAME                         READY     STATUS    RESTARTS   AGE
etcd-2810752095-054xb        1/1       Running   0          1h
flower-57424757-xqzls        1/1       Running   0          1m
postgresql-0                 1/1       Running   0          1h
rabbitmq-646028817-0bwgp     1/1       Running   0          1h
rabbitmq-646028817-3hb1z     1/1       Running   0          1h
rabbitmq-646028817-sq6cw     1/1       Running   0          1h
scheduler-1793121224-z57t9   1/1       Running   0          1m
web-1556478053-t06t9         1/1       Running   0          1m
worker-3775326852-0747g      1/1       Running   0          1m

```


To check that all resources are working as intended:

```
$ kubectl get all --namespace=airflow
NAME                            READY     STATUS    RESTARTS   AGE
po/etcd-2810752095-054xb        1/1       Running   0          1h
po/flower-57424757-xqzls        1/1       Running   0          1m
po/postgresql-0                 1/1       Running   0          1h
po/rabbitmq-646028817-0bwgp     1/1       Running   0          1h
po/rabbitmq-646028817-3hb1z     1/1       Running   0          1h
po/rabbitmq-646028817-sq6cw     1/1       Running   0          1h
po/scheduler-1793121224-z57t9   1/1       Running   0          1m
po/web-1556478053-t06t9         1/1       Running   0          1m
po/worker-3775326852-0747g      1/1       Running   0          1m

NAME             CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
svc/etcd         10.102.166.90    <none>        2379/TCP         1h
svc/flower       10.105.87.167    <nodes>       5555:32081/TCP   1m
svc/postgresql   10.96.110.4      <none>        5432/TCP         1h
svc/rabbitmq     10.100.94.226    <none>        5672/TCP         1h
svc/web          10.103.245.128   <nodes>       8080:32080/TCP   1m

NAME                      DESIRED   CURRENT   AGE
statefulsets/postgresql   1         1         1h

NAME                              DESIRED   SUCCESSFUL   AGE
jobs/airflow-db-init-postgresql   1         1            1m
jobs/airflow-db-sync              1         1            1m

NAME               DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deploy/etcd        1         1         1            1           1h
deploy/flower      1         1         1            1           1m
deploy/rabbitmq    3         3         3            3           1h
deploy/scheduler   1         1         1            1           1m
deploy/web         1         1         1            1           1m
deploy/worker      1         1         1            1           1m

NAME                      DESIRED   CURRENT   READY     AGE
rs/etcd-2810752095        1         1         1         1h
rs/flower-57424757        1         1         1         1m
rs/rabbitmq-646028817     3         3         3         1h
rs/scheduler-1793121224   1         1         1         1m
rs/web-1556478053         1         1         1         1m
rs/worker-3775326852      1         1         1         1m
```
