This guide assumes Minikube is already installed on an EC2 instance.

Step 1: Start Minikube
First, we need to start Minikube which will start a local Kubernetes cluster.
Use this command in your terminal:
```bash
minikube start
```
Step 2: Understanding YAML for Kubernetes
In Kubernetes, everything is defined in YAML files. Let's take a look at a simple example for a pod:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: nginx
    ports:
    - containerPort: 80
```
In this YAML file:
- The `apiVersion` specifies the Kubernetes API version.
- The `kind` specifies the type of Kubernetes object you want to create. Here, we're creating a Pod.
- `metadata` includes data about the Pod, like its name and labels.
- `spec` describes the desired state of the Pod. Here, we're specifying that we want a single container running the `nginx` image, and we want to open port 80 on that container.

Step 3: Apply the YAML File
Now we can use the `kubectl apply` command to create the pod defined in our YAML file.
```bash
kubectl apply -f mypod.yaml
```
This command will tell Kubernetes to create a pod as described in `mypod.yaml`.

Step 4: Check the Pod
We can use the `kubectl get pods` command to check the status of our pod.
```bash
kubectl get pods
```
This will output information about all pods, including their status. Once the status of the pod is `Running`, it means it's ready to be used.

Step 5: Accessing the Pod
To access the pod, we can use the kubectl command `kubectl port-forward`.
```bash
kubectl port-forward mypod 8080:80
```
Now, you can access the nginx server by going to `http://localhost:8080` in your web browser.

Step 6: Delete the Pod
When you're done with the pod, you can delete it with the `kubectl delete` command.
```bash
kubectl delete pod mypod
```
This will stop and delete the pod.

Step 7: Stop Minikube
Minikube can be stopped when you are done with your task. Use the following command to stop Minikube:
```bash
minikube stop
```
This command will stop the running Minikube virtual machine, but it will not delete any of your cluster configurations.

This is a basic introduction to Kubernetes. There are many other concepts to explore such as Deployments, Services, ConfigMaps, Secrets and more. Each of these can be managed with YAML files and `kubectl` commands just like the Pod example above.