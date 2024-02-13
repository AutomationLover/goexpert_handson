# Week 4: Docker & Containerisation

## Level 1 (Intern)
**Task**: Pull a public Docker image and run it. Use Docker commands to list and stop containers.

**Objective**: Execute basic Docker commands and run containers.

### Step by Step Guide:

1. **Install Docker**
    - Visit [Docker's website](https://www.docker.com/products/docker-desktop) and download Docker Desktop.
    - Install Docker Desktop by following the instructions provided by the installer.
2. **Pull a Docker Image**
    - Open a terminal.
    - Pull an image using the command: `docker pull <image-name>`.
    - For example, to pull nginx image, run `docker pull nginx`.
3. **Run the Docker Image**
    - Run the image using the command: `docker run -d -p 8080:80 <image-name>`.
    - For example, to run nginx, run `docker run -d -p 8080:80 nginx`.
4. **List Docker Containers**
    - Run the command: `docker ps`.
5. **Stop a Docker Container**
    - Find the Container ID from the output of the `docker ps` command.
    - Run the command: `docker stop <container-id>`.

## Level 2 (Junior)
**Task**: Build a custom Docker image for a simple app and push it to AWS ECR.

**Objective**: Learn Docker image creation and management.

### Step by Step Guide:

1. **Create a Dockerfile**
    - Create a file named Dockerfile in your application directory.
    - Fill it with instructions to build your Docker image. A simple Node.js app's Dockerfile might look like this:

    ```
    FROM node:14
    WORKDIR /usr/src/app
    COPY package*.json ./
    RUN npm install
    COPY . .
    EXPOSE 8080
    CMD [ "node", "server.js" ]
    ```

2. **Build the Docker Image**
    - Run the command: `docker build -t <image-name> .`.
    - For example, to build an image named my-app, run `docker build -t my-app .`.

3. **Push the Docker Image to AWS ECR**
    - Install the AWS CLI and configure it with your AWS credentials.
    - Create a repository in AWS ECR.
    - Authenticate Docker to your ECR registry with the command: `aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <your-ecr-repository-url>`
    - Tag your image to match your repository name: `docker tag <image-name>:<tag> <your-ecr-repository-url>`
    - Push your image with: `docker push <your-ecr-repository-url>`

## Level 3 (Mid-level)
**Task**: Add Docker support to an existing CI/CD pipeline.

**Objective**: Understand how containerisation integrates with CI/CD pipelines.

### Step by Step Guide:

1. **Integrate Docker into your Build Process**
    - In your CI/CD pipeline configuration, add a new step to build your Docker image.
    - This step will use the `docker build` command you used earlier.

2. **Push your Docker Image in the Deploy Process**
    - In your pipeline configuration, add a new step in your deploy process to push your Docker image to AWS ECR.
    - This step will use the `docker push` command you used earlier.

3. **Deploy your Docker Image**
    - In the deploy phase, add a step to pull the Docker image from ECR and run it on your servers.
    - This could be done using AWS ECS, Kubernetes, or any other container orchestration tool that you are using.

4. **Test your CI/CD Pipeline**
    - Commit your changes and push to your repository to trigger the CI/CD pipeline.
    - Monitor the pipeline to ensure the Docker image is built, pushed to ECR, and successfully deployed.

Remember, the objective of these tasks is to give you a hands-on understanding of Docker and its integration with CI/CD pipelines. As you grow more comfortable with these technologies, you can explore more complex applications and configurations.