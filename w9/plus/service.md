To demonstrate how to expose a service in Kubernetes and use this service in another container in a separate pod, you can follow these steps:
Create a Deployment for the Service:
Create a deployment for the service you want to expose. Here is an example YAML file for the deployment:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: service-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: service
  template:
    metadata:
      labels:
        app: service
    spec:
      containers:
        - name: service-container
          image: nginx:latest
          ports:
            - containerPort: 80
```

Create a Service for the Service Deployment:
Create a ClusterIP service to expose the service-container within the cluster. Here is an example YAML file for the service:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: service-clusterip
spec:
  selector:
    app: service
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
```


Create a Consumer Pod:
Create a separate pod that will consume the service exposed by the service-clusterip. Here is an example YAML file for the consumer pod:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: consumer-pod
spec:
  containers:
    - name: consumer-container
      image: busybox
      command: ["/bin/sh", "-c", "while true; do wget -qO- http://service-clusterip.default.svc.cluster.local; sleep 1; done"]
```

Apply the Configurations:
Apply the deployment, service, and consumer pod configurations using `kubectl apply -f <filename.yaml>`.
Verify the Setup:
Check if the service deployment, ClusterIP service, and consumer pod are running correctly using kubectl get pods and kubectl get services.
Access the Service from Consumer Pod:
The consumer-container in the consumer-pod can access the service-container through the ClusterIP of service-clusterip. In this case, it will use http://service-clusterip.default.svc.cluster.local.
View Logs (Optional):
You can view logs of the consumer-container in the consumer-pod to see if it successfully consumes the service by running kubectl logs <consumer-pod-name>.
By following these steps, you can expose a service in Kubernetes and demonstrate how another container in a separate pod within the same cluster can consume this service. This setup showcases inter-pod communication using services in Kubernetes.
