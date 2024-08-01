# Step-by-Step Guide for Studying Docker Networking

Understanding Docker's networking capabilities is crucial for managing and deploying containerized applications efficiently. This guide will lead you through exploring different aspects of Docker networking, utilizing the Docker CLI for hands-on learning.

## Task: Understanding Basic Docker Networking Concepts
- **Step 1**: Start by familiarizing yourself with the basics of Docker containers. Run a simple container using BusyBox, a minimalist Linux distribution:
  ```bash
  docker run -it busybox
  ```
- **Step 2**: Inside the container, check the IP address assigned to it. This helps in understanding how Docker assigns private IP addresses to containers for internal communication.
  ```bash
  hostname -i
  ```
- **Step 3**: Check the container ID by using the `hostname` command. This ID is crucial for identifying containers within the Docker system.
  ```bash
  hostname
  ```
- **Step 4**: Exit the container and use `docker ps` to list all running containers. Note the CONTAINER ID and NAMES for later use.
  ```bash
  docker ps
  ```

## Task: Exploring Docker Networks
- **Step 1**: Inspect the default bridge network. Docker creates a default bridge network that allows container communication. Inspect it to see how it is configured and which containers are currently attached.
  ```bash
  docker network inspect bridge
  ```
- **Step 2**: Create a custom network. This is useful for creating isolated networks for your applications.
  ```bash
  docker network create customer
  ```
- **Step 3**: Run a container in the newly created custom network. This demonstrates how to explicitly attach a container to a specific network.
  ```bash
  docker run --network customer -it busybox
  ```
  Inside the container, check the IP address as before to see how it differs from the default bridge network.
  ```bash
  hostname -i
  ```

## Task: Experimenting with Different Base Images and Networks
- **Step 1**: Explore using a different base image, such as Alpine, which is another minimalist Linux distribution. Notice how Docker handles images not present locally.
  ```bash
  docker run -it alpine
  ```
- **Step 2**: Inside the Alpine container, inspect the IP address and routing information. Comparing these details between different containers can help understand Docker's networking model.
  ```bash
  ip address
  ip route
  ```
  ## Task: Networking Between Docker Containers
- **Step 1**: Start by running two containers within the same network (use the custom network created earlier for isolation).
  ```bash
  docker run --network customer --name container1 -itd busybox
  docker run --network customer --name container2 -itd busybox
  ```
- **Step 2**: Inspect the custom network again to verify both containers are attached. This step helps understand how Docker networks facilitate inter-container communication.
  ```bash
  docker network inspect customer
  ```
- **Step 3**: Attach to one container and ping the other by its name. This demonstrates DNS resolution within Docker networks, allowing containers to communicate using container names instead of IP addresses.
  ```bash
  docker attach container1
  ping container2
  ```

## Task: Exploring Docker Network Commands
- **Step 1**: Learn to list all networks on your Docker host. This gives an overview of the networking setup.
  ```bash
  docker network ls
  ```
- **Step 2**: Understand how to disconnect a container from a network. This is useful for managing network configurations and troubleshooting.
  ```bash
  docker network disconnect customer container1
  ```
- **Step 3**: Reconnect the container to the network. This demonstrates how to modify network connections for existing containers without restarting or recreating them.
  ```bash
  docker network connect customer container1
  ```
- **Step 4**: Remove a custom network. This step is crucial for cleaning up and maintaining the Docker environment. Note that networks can only be removed when no containers are connected to them.
  ```bash
  docker network rm customer
  ```

## Task: Bridge Network Deep Dive
- **Step 1**: Investigate how port mapping works with the default bridge network. Run a container with a specific port exposed and mapped to the host.
  ```bash
  docker run -d -p 8080:80 nginx
  ```
- **Step 2**: Use `docker ps` to verify the port mapping. This step is essential for understanding how Docker exposes container services to the host network or external networks.
  ```bash
  docker ps
  ```
- **Step 3**: Access the service running in the container (e.g., nginx) through the mapped port on your host machine's browser or using curl. This demonstrates the accessibility of containerized applications via network.
  ```bash
  curl http://localhost:8080
  ```

## Task: Experimenting with Overlay Networks in Docker Swarm
- **Step 1**: Initialize Docker Swarm mode to create a cluster. This is necessary for creating overlay networks that span multiple Docker hosts.
  ```bash
  docker swarm init
  ```
- **Step 2**: Create an overlay network. Overlay networks enable containers running on different Docker hosts within the same swarm cluster to communicate as if they were on the same host.
  ```bash
  docker network create --driver overlay my_overlay
  ```
- **Step 3**: Deploy services to the overlay network. This illustrates how applications can be scaled and managed across multiple nodes in a swarm.
  ```bash
  docker service create --name web --network my_overlay -p 80:80 nginx
  ```
- **Step 4**: Scale the service to run across multiple nodes. This step demonstrates the load balancing capabilities of Docker Swarm across the overlay network.
  ```bash
  docker service scale web=3
  ```

## Task: Using Docker Compose for Multi-Container Networking
- **Step 1**: Create a `docker-compose.yml` file for defining and running multi-container Docker applications. Include services that need to communicate with each other.
- **```yaml
version: '3'
services:
  web:
    image: nginx
    ports:
      - "80:80"
  app:
    image: myapp
    networks:
      - my_custom_network
  db:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: password
networks:
  my_custom_network:
```
- **Step 2**: Use Docker Compose to start up your multi-container application defined in the `docker-compose.yml` file. This demonstrates how Docker Compose manages network creation and inter-container connectivity.
  ```bash
  docker-compose up -d
  ```
- **Step 3**: Inspect the network created by Docker Compose to understand how it automatically sets up networking between the containers specified in the `docker-compose.yml` file.
  ```bash
  docker network inspect <your_project_name>_my_custom_network
  ```
- **Step 4**: Execute commands within the context of your service's container using Docker Compose. This can be useful for debugging networking issues or verifying connectivity.
  ```bash
  docker-compose exec app ping db
  ```

## Task: Cleaning Up
- **Step 1**: It's important to clean up resources to prevent conflicts and conserve system
```yaml
version: '3'
services:
  web:
    image: nginx
    ports:
      - "80:80"
  app:
    image: myapp
    networks:
      - my_custom_network
  db:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: password
networks:
  my_custom_network:
```
- **Step 2**: Use Docker Compose to start up your multi-container application defined in the `docker-compose.yml` file. This demonstrates how Docker Compose manages network creation and inter-container connectivity.
  ```bash
  docker-compose up -d
  ```
- **Step 3**: Inspect the network created by Docker Compose to understand how it automatically sets up networking between the containers specified in the `docker-compose.yml` file.
  ```bash
  docker network inspect <your_project_name>_my_custom_network
  ```
- **Step 4**: Execute commands within the context of your service's container using Docker Compose. This can be useful for debugging networking issues or verifying connectivity.
  ```bash
  docker-compose exec app ping db
  ```

## Task: Cleaning Up
- **Step 1**: It's important to clean up resources to prevent conflicts and conserve system
resources. Start by stopping the multi-container application managed by Docker Compose.
  ```bash
  docker-compose down
  ```
- **Step 2**: Remove individual containers if they were not defined using Docker Compose. This helps in avoiding any unused or dangling containers on your system.
  ```bash
  docker rm -f container1 container2 web
  ```
- **Step 3**: Remove custom networks that are no longer in use. This is a crucial step in maintaining a clean Docker environment.
  ```bash
  docker network rm customer my_overlay
  ```
- **Step 4**: If you enabled Docker Swarm mode for exploring overlay networks, you might want to leave the swarm mode to reset your Docker environment to its original state.
  ```bash
  docker swarm leave --force
  ```

## Conclusion

By following this step-by-step guide, you should now have a foundational understanding of Docker networking, including basic container-to-container communication, the use of default and custom networks, port mapping, and more advanced topics like overlay networks in Docker Swarm and multi-container orchestration with Docker Compose. Remember, hands-on practice is key to mastering Docker networking, so experiment with different configurations and scenarios to deepen your understanding.