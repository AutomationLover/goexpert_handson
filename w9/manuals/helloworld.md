Sure, I'll walk you through deploying a simple HelloWorld website on Kubernetes. Note that Kubernetes (k8s) is a powerful container orchestration system and it might be complex for beginners, but don't worry, I'll try to make it as simple as possible.

1. ### Creating a Docker Image ###
    First, we need a Docker image to deploy. Let's create a simple HelloWorld website using Node.js. Create a new directory and navigate into it. In this directory, create two files: `server.js` and `Dockerfile`.

    `server.js` content:
    ```javascript
    const http = require('http');

    const server = http.createServer((req, res) => {
      res.statusCode = 200;
      res.setHeader('Content-Type', 'text/plain');
      res.end('Hello World\n');
    });

    const port = process.env.PORT || 3000;
    server.listen(port, () => {
      console.log(`Server running on http://localhost:${port}/`);
    });
    ```
    `Dockerfile` content:
    ```Dockerfile
    FROM node:14
    WORKDIR /usr/src/app
    COPY package*.json ./
    RUN npm install
    COPY . .
    EXPOSE 8080
    CMD [ "node", "server.js" ]
    ```
Now, create a `package.json` file with the following content:

```json
{
  "name": "helloworld",
  "version": "1.0.0",
  "description": "",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.17.1"
  }
}
```

Build your docker image using the following command:

```bash
docker build -t helloworld .
```

2. ### Deploying the Docker Image to Kubernetes ###

As you already have minikube installed, start it:

```bash
minikube start
```

Now, let's create a Kubernetes Deployment using a YAML file. Create a new file called `helloworld-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: helloworld-deployment
  labels:
    app: helloworld
spec:
  replicas: 3
  selector:
    matchLabels:
      app: helloworld
  template:
    metadata:
      labels:
        app: helloworld
    spec:
        containers:
        - name: helloworld
          image: helloworld:latest
          ports:
          - containerPort: 8080
```
This YAML file tells Kubernetes to create a Deployment named "helloworld-deployment" with 3 replicas, each serving the "helloworld" Docker image on port 8080.

Apply the Deployment:

```bash
kubectl apply -f helloworld-deployment.yaml
```

3. ### Expose the Deployment ###

We need to expose our Deployment so that it's accessible from outside the cluster. Let's create a Service for that. Create a new file called `helloworld-service.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: helloworld-service
spec:
  selector:
    app: helloworld
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: LoadBalancer
```
This YAML file tells Kubernetes to create a Service named "helloworld-service" that routes traffic from port 80 to the target port 8080 of any Pod with the label "app=helloworld". 

Apply the Service:

```bash
kubectl apply -f helloworld-service.yaml
```

4. ### Accessing the HelloWorld Website ###

Since our service is of type `LoadBalancer`, it's accessible from outside the cluster. You can get the service's IP address by running:

```bash
minikube service helloworld-service --url
```

Open the URL in your web browser, and you should see "Hello World".

5. ### Scaling In and Out ###

You can scale the application by increasing or decreasing the number of replicas in the deployment. To scale out, run:

```bash
kubectl scale deployments/helloworld-deployment --replicas=5
```

This increases the replicas to 5. To scale in, run:

```bash
kubectl scale deployments/helloworld-deployment --replicas=2
```

This reduces the replicas to 2.

6. ### Updating the Application ###

To update the application, you would need to build a new Docker image with the changes, push it to a registry (or load it directly into minikube), and update the image in the deployment.

For example, let's say we've made changes and built a new image tagged `helloworld:v2`. We can update the deployment with:

```bash
kubectl set image deployment/helloworld-deployment helloworld=helloworld:v2
```
This command tells Kubernetes to update the image of the "helloworld" container in the "helloworld-deployment" Deployment to "helloworld:v2".

7. ### Cleaning Up ###

Finally, when you're done, you can delete the Deployment and Service with:

```bash
kubectl delete service helloworld-service
kubectl delete deployment helloworld-deployment
```

And stop Minikube with:

```bash
minikube stop
```

That's it! You've successfully deployed a HelloWorld website on Kubernetes, scaled it in and out, updated it, and cleaned everything up. I hope this gives you a good introduction to some of the most commonly used features in Kubernetes.
