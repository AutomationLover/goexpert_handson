# AWS Networking Concepts

## 1. Virtual Private Cloud (VPC)
A VPC is a virtual network dedicated to your AWS account. It allows you to control your virtual networking environment, which includes IP address range, subnets, route tables, and network gateways.

## 2. Subnets
A subnet is a range of IP addresses in your VPC. You can launch AWS resources into a subnet that you select. There are two types of subnets: 
- **Public Subnet:** A subnet whose traffic is routed to an Internet Gateway.
- **Private Subnet:** A subnet that doesn't have a route to the Internet Gateway.

## 3. Internet Gateway
An Internet Gateway is a horizontally scaleable, redundant, and highly available VPC component that allows communication between instances in your VPC and the internet.

## 4. NAT Gateway
A NAT Gateway enables instances in a private subnet to connect to the internet or other AWS services, but prevents the internet from initiating a connection with those instances.

## 5. Route Tables
A Route Table contains a set of rules, called routes, that are used to determine where network traffic is directed.

## 6. Security Groups
A security group acts as a virtual firewall for your instance to control inbound and outbound traffic. It contains a set of rules that determine the traffic allowed to and from instances.

## 7. Network Access Control Lists (NACLs)
NACLs provide a rule-based tool for controlling network traffic ingress and egress at the protocol and subnet level in a VPC.

## 8. Elastic IP Address
An Elastic IP address is a static, public IPv4 address, which can be associated with your AWS account, and you can mask the failure of an instance by remapping your public IP addresses to any instance associated with your account.

## 9. VPC Peering
VPC Peering is a networking connection between two VPCs that enables you to route traffic between them privately.

## 10. Virtual Private Network (VPN)
A VPN extends your own network to AWS over a secure, private connection which is not transmitted over the public internet.

## 11. Direct Connect
AWS Direct Connect is a network service that provides an alternative to using the internet to utilize AWS cloud services. It uses dedicated network connections between your network and AWS.

These are the fundamental AWS networking concepts that will help you to build more secure and scalable applications.