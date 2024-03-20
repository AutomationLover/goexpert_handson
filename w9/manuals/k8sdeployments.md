
**Step 1: Start minikube**
Before starting minikube, you should check the status:

```bash
minikube status
```

If minikube is not running, you can start it with the following command:

```bash
minikube start
```

**Step 2: Create a Deployment**
Kubernetes Pods are the smallest and simplest units in the Kubernetes object model that you create or deploy. A Pod represents a running process on your cluster.
A Deployment is a higher-level concept that manages Pods and ReplicaSets. 

Let's create a simple deployment with a yaml file. Name the file `myapp-deployment.yaml`.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-deployment
spec:
  selector:
    matchLabels:
      app: myapp
  replicas: 2
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp-container
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```

The `replicas: 2` field means that the deployment will manage two pods, each running an Nginx server.

To create the deployment, use the `kubectl apply` command:

```bash
kubectl apply -f myapp-deployment.yaml
```

**Step 3: Check the Deployment, Pods and ReplicaSets**

You can check the status of the deployment with:

```bash
kubectl get deployments
```

To view the Pods:

```bash
kubectl get pods
```

And to view the ReplicaSets:

```bash
kubectl get rs
```

**Step 4: Scaling the Deployment**

You can scale the deployment to manage more pods with the `kubectl scale` command:

```bash
kubectl scale deployments/myapp-deployment --replicas=4
```

This will increase the number of pods to 4.

**Step 5: Check the scaled Deployment**

Check the status of the scaled deployment:

```bash
kubectl get deployments
```

You should see 4 pods for the myapp-deployment.

**Step 6: Delete the Deployment**

If you want to delete the deployment, you can do that with the `kubectl delete` command:

```bash
kubectl delete -f myapp-deployment.yaml
```

Or you can delete the deployment by its name:

```bash
kubectl delete deployments myapp-deployment
```

This tutorial only scratches the surface of what you can do with Kubernetes and minikube. Kubernetes offers a lot more features and complexity that is beyond the scope of this basic tutorial.

Remember, always check the status of your deployments, pods, and services with `kubectl get` command to make sure everything is running as expected.