### Week 10 DevOps Networking Lesson

This guide is designed to help you understand and implement basic to advanced networking concepts relevant to DevOps, focusing on public and private IP addresses, NAT, AWS networking, and Kubernetes (k8s) networking.

#### Level 1 (Beginner): Network Basics

1. **Understanding IP Addresses**:
    - **Public IP Address**: Identifies a device on the internet. It is globally unique and accessible over the internet.
    - **Private IP Address**: Used within a private network. It is not routable on the internet. Common private IP ranges include 192.168.x.x, 10.x.x.x, and 172.16.x.x to 172.31.x.x.

2. **Network Address and Host IP Address**:
    - The **network address** represents your whole network, often defined by the first IP in a subnet.
    - A **host IP address** is an address assigned to an individual device within a network.

3. **NAT (Network Address Translation)**:
    - **Why NAT?**: It allows multiple devices on a private network to share a single public IP address. It's a method to conserve public IPs and enhance security.
    - **Where to Use NAT - **Verifying NAT**: You can verify NAT functionality by checking the public IP your network communicates with the outside world (`https://whatismyipaddress.com/`) and comparing it with your device’s private IP (Use `ipconfig` on Windows or `ifconfig` on Linux/Mac).

4. **Overlay Networks (e.g., VxLAN)**:
    - Used to connect containers or virtual machines across different hosts by creating a virtual network layer over the physical network.
    - **Example**: In Docker, you can create an overlay network allowing containers on different Docker hosts to communicate as if they were on the same host.

#### Level 2 (Intermediate): AWS Network

1. **Checking EC2 IP Addresses**:
    - **Public IP**: Find it in the EC2 dashboard under the "IPv4 Public IP" column.
    - **Private IP**: Also listed in the EC2 dashboard under the "Private IPs" column.
    - To check via CLI: `aws ec2 describe-instances --query "Reservations[*].Instances[*].[PublicIpAddress, PrivateIpAddress]"`

2. **Subnet's Network Address**:
    - In AWS VPC, each subnet has a CIDR block that defines its network address range.

3. **AWS Elastic IP (EIP) and NAT Gateway**:
    - **EIP**: A static IPv4 address offered by AWS for dynamic cloud computing. You can associate it with any instance in your VPC and it can be remapped to another instance in case of failure.
    - **NAT Gateway**: A highly available AWS managed service allowing instances in a private subnet to connect to the internet or other AWS services but prevent the internet from initiating a connection with those instances.
        - To set up a NAT Gateway, navigate to the VPC dashboard in AWS, select “NAT Gateways”, and follow the creation wizard. Remember, the NAT Gateway should be placed in a public subnet.

#### Level 3 (Advanced): Kubernetes (k8s) Network

1. **Docker and Bridge Network**:
    - Docker containers connect to the Docker daemon’s bridge network (`bridge0`) by default, which allows them to communicate with each other and the host.
    - To inspect the Docker network, use: `docker network inspect bridge`

2. **Kubernetes CNI (Container Network Interface)**:
    - Kubernetes uses CNI plugins to facilitate networking between pods across the cluster. Plugins like Calico, Flannel, or Weave create a network overlay that ensures all pods can communicate with each other, regardless of the node they are running on.
    - To apply a CNI plugin, you typically apply a configuration manifest to your cluster. For example, for Calico, you would use: `kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml`

3. **Understanding Kubernetes Services**:
    - Kubernetes Services provide a way to expose an application running on a set of Pods as a network service. Since Pod IP addresses are ephemeral, Services allow your application to be reachable through a stable endpoint.
    - To create a Service that targets Pods with the `app=service` label and maps port 80 on the service to port 80 on the Pod, you would use a YAML definition like this:

        ```yaml
        apiVersion: v1
        kind: Service
        metadata:
          name: my-service
        spec:
          selector:
            app: service
          ports:
            - protocol: TCP
              port: 80
              targetPort: 80
        ```

    - Apply this configuration using: `kubectl apply -f <filename>.yaml`

4. **Inspecting Kubernetes Services and Endpoints**:
    - To describe a service and its endpoints, which effectively shows how the service is configured and which Pods are targeted by the service, you can use the following `kubectl` commands:

    ```shell
    kubectl describe service my-service
    ```
    This command provides detailed information about the service named "my-service", including its type, IP, ports, and the selector used to identify the Pods it targets.

    ```shell
    kubectl describe endpoints my-service
    ```
    This command shows the endpoints object created for "my-service", listing the IP addresses of the Pods that the service routes traffic to. Endpoints are automatically created based on the Pod selector specified in the service definition.

**Recap and Further Steps**:
- In **Level 1**, you've learned about basic networking concepts including IP addresses, NAT, and overlay networks like VxLAN.
- **Level 2** focused on AWS-specific networking, teaching you how to check public and private IP addresses of an EC2 instance, understand the network address of an EC2’s subnet, and the use of AWS EIP and NAT Gateway.
- Finally, **Level 3** dived into Kubernetes networking, covering Docker bridge networks, Kubernetes CNI, and the importance of Services and Endpoints in describe a service and its endpoints, which effectively shows how the service is configured and which Pods are targeted by the service, you can use the following `kubectl` commands:

    ```shell
    kubectl describe service my-service
    ```
    This command provides detailed information about the service named "my-service", including its type, IP, ports, and the selector used to identify the Pods it targets.

    ```shell
    kubectl describe endpoints my-service
    ```
    This command shows the endpoints object created for "my-service", listing the IP addresses of the Pods that the service routes traffic to. Endpoints are automatically created based on the Pod selector specified in the service definition.

**Recap and Further Steps**:
- In **Level 1**, you've learned about basic networking concepts including IP addresses, NAT, and overlay networks like VxLAN.
- **Level 2** focused on AWS-specific networking, teaching you how to check public and private IP addresses of an EC2 instance, understand the network address of an EC2’s subnet, and the use of AWS EIP and NAT Gateway.
- Finally, **Level 3** dived into Kubernetes networking, covering Docker bridge networks, Kubernetes CNI, and the importance of Services and Endpoints in Kubernetes for stable and dynamic networking between pods.

As you progress through these levels, remember that networking is a vast and complex domain within DevOps and cloud computing. Each concept builds upon the previous ones, and practical experience is invaluable. Experiment with different CNI plugins, explore AWS networking features, and try to set up your Kubernetes services to get a deeper understanding.

For further learning, consider setting up more complex networking scenarios:
- Create a multi-tier application in Kubernetes and explore how to use Services, Ingress, and Network Policies to control access and traffic flow.
- Experiment with more advanced AWS networking features like Transit Gateways, VPC Peering, and Direct Connect to understand how to architect for large scale and interconnectivity between different AWS VPCs or between AWS and on-premises environments.
- Dive deeper into overlay networking by setting up and testing different network overlays in a lab environment to see how they handle network segmentation, scalability, and cross-host communication.

Networking is a foundational skill in DevOps that supports reliability, scalability, and security in your applications and infrastructure. Keep exploring, learning, and experimenting to master these concepts.