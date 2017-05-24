## aic-helm/airflow ##

This chart installs airflow on kubernetes

###Quickstart###

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
