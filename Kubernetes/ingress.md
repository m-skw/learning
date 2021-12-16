# Kubernetes - Ingress

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

# What is Ingress and what is it used for?

Ingress is Kubernetes service that is used for exposing pod (app) for remote connections. Another use case is to create multiple paths for same host. For example domain name for an application is myapp.com. Application is offering shopping and renting services. You can create a rule to redirect traffic from myapp.com/shopping to responsible pod and myapp.com/renting to another pod responsible for handling this type of requests.

Other use case is when you want to create multiple sub-domains applications.
Comparing it with previous example, you can create something like this:

http://renting.myapp.com
http://shopping.myapp.com

# How to start using Ingress service

You need to install Ingress Controller, it may be created inside of created cluster or in separate machine outside of cluster. You must review your environment, many of the cloud providers offers their load balancers that integrates with cluster.

For standalone cluster there is a list of available controllers:
https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/

For bare metal consideration:
https://kubernetes.github.io/ingress-nginx/deploy/baremetal/

# Ingress vs External Service

Both do similiar jobs but external service is mostly used for developing/testing purposes.
Main difference is to access pod using ES you must specify IP address of this service and then exposed port.

```yaml
    example for External Service
    http://172.168.1.20:30001
```

For Ingress you can specify domain name for this pod and even secure this connection with https.

```yaml
    example for Ingress
    https://my-app.net
```

It means that you should always use Ingress instead of External Service for final production applications.

# Differences in YAML configuration file

1. Ingress
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: myapp-ingress
spec:
  rules:
  - host: myapp.com
    http:
      paths:
      - backend:
          serviceName: myapp-internal-service
          servicePort: 8080
```
Any request from myapp.com should be forwarded to internal service myapp-internal-service on port 8080

2. External Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mongo-express-service
spec:
  selector:
    app: mongoexpress
  type: LoadBalancer   #this is property of external service
  ports:
    - protocol: TCP
      port: 8081       #port of the service
      targetPort: 8081 #port of the pod
      nodePort: 30001  #port for external IP (must be between 30000-32767)
```

# Example of multiple paths

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: myapp
  namespace: myapp
spec:
  rules:
  - host: myapp.com
    http:
      paths:
        - path: /shopping
          pathType: Prefix
          backend:
            service:
              name: shopping-service
              port:
                number: 3000
        - path: /renting
          pathType: Prefix
          backend:
            service:
              name: renting-service
              port:
                number: 4000
```

# Example of multiple sub-domains

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: myapp
  namespace: myapp
spec:
  rules:
  - host: shopping.myapp.com
    http:
      paths:
          backend:
            service:
              name: shopping-service
              port:
                number: 3000
  - host: renting.myapp.com
    http:
      paths:
          backend:
            service:
              name: renting-service
              port:
                number: 4000
```

# Using TLS certificates

To use Ingress with https you must configure secret with it's properties.
Secret file looks like this

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: myapp-secret-tls
  namespace: myapp
data:
  tls.cert: base64 encoded cert
  tls.key: base64 encoded key
type: kubernetes.io/tls
```

!!! NOTE !!!

Normally in secret you can provide any key-value names.
 - In TLS type keys must be named like this!
 - Values are actual content, not path to file.
 - Secret must be in the same namespace as the ingress component

You must specify this secret in ingress yaml file

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: myapp-ingress
spec:
  tls:
  - hosts:
    - myapp.com
    secretName: myapp-secret-tls
  rules:
  - host: myapp.com
    http:
      paths:
      - backend:
          serviceName: myapp-internal-service
          servicePort: 8080
```