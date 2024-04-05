# Week 10 Networking

## Level 1 (Beginner)
**Task**: Understand the Basics of Networking
- Explore Public and Private IP Addresses
- Learn about Network Addresses and Host IP Addresses
- Understand NAT (Network Address Translation), its purposes, and applications. Perform verification of NAT functionality between public and private IP addresses
- Discover alternative networking methods such as VxLAN for connecting containers across different hosts

**Objective**: Grasp the Fundamentals of Networking

## Level 2 (Intermediate)
**Task**: Dive into AWS Networking
- Identify the Public and Private IP Addresses of an EC2 Instance
- Determine the Network Address of an EC2 Instance’s Subnet
- Explore AWS’s Elastic IP (EIP) and NAT Gateway

**Objective**: Master AWS Networking Concepts

### Level 3 (Advanced)
**Task**: Explore Kubernetes Networking
- Investigate Docker Networking and the bridge0 Interface
- Understand Kubernetes CNI (Container Network Interface)
- Learn why Kubernetes needs Services for non-static Pod IPs and to fulfill load balancing requirements among a group of Pod instances
- Utilize selector fields to designate a Service that proxies Pods tagged with "app=service". This Service proxies traffic from its port 80 to the Pod's port 80.

**Objective**: Achieve Proficiency in Kubernetes Networking

Commands to explore:
- `kubectl describe service <service-name>`
- `kubectl describe endpoints <endpoint-name>`