# Kubernetes - Namespaces

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

# Use cases when to use Namespaces

1. Structure your components
2. Avoid conficts between teams
3. Share Services between different environments
4. Access and Resource Limits on Namespaces level

# Characteristics of Namespaces

- You can't access most resources from another namespace
That means if you have configmap in one NS that references database from other NS you can access it but you must specify same
configmap in other NSs, same happens for secrets, these resources aren't shared between environments
- Resources that cannot be added to namespaces, they live globally in k8:
    a) volumes, they will be accessible through whole cluster
    b) nodes
- If you don't provide namespace in deployment it will be created in default namespace

# Usage

- To reference for example pod named "mysql-service" that belongs to "database" namespace:
    ```
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: mysql-configmap
    data:
       database_url: mysql-service.database #.database means resource in "database" namespace
    ```
- To list resources in cluster that are not namespaced
    ```
    kubectl api-resources --namespaced=false / true
    ```
- To apply deployment with namespace:
    a) ```kubectl apply -f mysql-configmap.yml --namespace=my-namespace```
    b) in yaml file itself (preffered, better documented, better for automation):
    ```yml
    apiVersion: v1
      kind: ConfigMap
      metadata:
        name: mongodb-configmap
        namespace: my-namespace
      data:
        database_url: mongodb-service
    ```
- Commang kubectl get looks only in  default namespace. To specify in which namespace to search
    ```
    kubectl get configmap -n my-namespace
    ```