This document guide you through deploying a service on k8s and scaling it. We'll use a simple Nginx server as an example. 

**Step 1:** We'll start by creating a Deployment. Here's a sample YAML file to create a Deployment that runs an Nginx server:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```

You can save this file as `nginx-deployment.yaml`. This Deployment will ensure that three replicas of the Nginx server are always running.

**Step 2:** To apply this Deployment, run the following command:

```
kubectl apply -f nginx-deployment.yaml
```

**Step 3:** Now let's expose the Nginx server using a Service. Here's a sample YAML file to create a Service:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
```

You can save this file as `nginx-service.yaml`. This Service will expose the Nginx server on a static port on each Node.

**Step 4:** To apply this Service, run the following command:

```
kubectl apply -f nginx-service.yaml
```

The Nginx server is now accessible via the LoadBalancer Service.

**Step 5:** If you want to scale the application, you can use the `kubectl scale` command. For example, to scale up the Deployment to 5 replicas, run the following command:

```
kubectl scale deployment/nginx-deployment --replicas=5
```

**Step 6:** To scale down the Deployment to 2 replicas, run the following command:

```
kubectl scale deployment/nginx-deployment --replicas=2
```

**Step 7:** K8s also has a feature to do auto-scaling based on CPU usage. Here's an example of how to use the Horizontal Pod Autoscaler:

```bash
kubectl autoscale deployment nginx-deployment --min=2 --max=5 --cpu-percent=80
```

This command will ensure that there are always between 2 and 5 replicas of the Deployment running, scaling up and down based on CPU usage.

**Step 8:** To view the status of the Deployment, Service, you can use the following commands:

```
kubectl get deployments
kubectl get services
```

This is a basic guide to deploying a service on Kubernetes, and scaling it both manually and automatically. There are many other features in Kubernetes that allow for even more complex deployments and management of applications.
