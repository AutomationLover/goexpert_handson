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
**Task**: Build a custom Docker image for a simple app and deploy it locally.

**Objective**: Learn Docker image creation and management.

### Step by Step Guide:

1. **Create a Dockerfile**
    - Create a file named Dockerfile in your application directory.
    - Fill it with instructions to build your Docker image. A simple Node.js app's Dockerfile might look like https://github.com/AutomationLover/website-visit-count/blob/main/Dockerfile

2. **Build the Docker Image**
    - Run the command: `docker build -t <image-name> .`.
    - For example, to build an image named my-app, run `docker build -t my-app .`.
    - Following steps https://github.com/AutomationLover/website-visit-count/blob/main/README.md, after git clone this repo

3. **Deploy App**
    - Deploy app with docker cli
    - Deploy app with docker compose
    - Deploy app with Docker Development Environments


## Level 3 (Mid-level)
**Task**: Change Docker file and compose file.
- update port
- update container name
- update python base image

**Objective**: Understand parameters in Docker file and compose file.



