In Amazon ECS, the network mode options determine how the networking is configured for the containers within a task. The available network modes are awsvpc, host, bridge, and none. Each mode has its own characteristics and use cases:

## awsvpc (Amazon VPC):
This mode provides each task with its own elastic network interface (ENI) and a primary private IPv4 address, giving the task the same networking properties as an Amazon EC2 instance. It offers more control over how applications communicate with each other and other services within your VPC. It also provides greater security for containers by allowing the use of security groups and network monitoring tools at a more granular level within your tasks. This mode is recommended for most use cases, especially when you want tasks to be accessible from the internet.
## host:
In this mode, the networking of the container is tied directly to the underlying host that's running the container. The container receives traffic on port 3000 using the IP address of the underlying host Amazon EC2 instance. However, there are significant drawbacks to using this mode, such as limitations on running multiple instantiations of a task on each host and security implications.
## bridge:
The bridge network mode is the default mode for Linux containers. It utilizes Docker’s built-in virtual network, which runs inside each container. It provides isolation from other containers not connected to that bridge network.
## none:
This mode completely disables the networking stack inside the ECS task. The loopback network interface is the only one present inside each container, and you can't specify port mappings on this mode as the containers do not have external connectivity.
If you want to deploy a web portal container in a public segment and make it accessible from the internet, the awsvpc mode is better suited for this purpose. It provides tasks with their own ENI and allows you to configure security groups and network monitoring tools at a more granular level within your tasks, which is important for securing access to your web portal from the internet.

# ref
https://docs.aws.amazon.com/AmazonECS/latest/bestpracticesguide/networking-networkmode.html
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking-awsvpc.html
