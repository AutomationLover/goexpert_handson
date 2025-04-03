AWS Networking Practice

Process
- Create VPC with cidr 10.1.0.0/16
- Create subnet name test-public
- Create a keypair for below step of EC2 creation
- Create EC2, name: testwithoutpublicip, attach to test-public, choose no public ip
- Create EC2, name: testwithpublicip,  attach to test-public, choose with public ip
- Update the SG for both EC2 to allow ICMP
- Create IGW, and attach to the new VPC created in previous step
- Update route table on test-public subnet, by adding 0.0.0.0/0 to this igw 
- Ping success to the public ip of the EC2 testwithpublicip, ssh to this EC2 
- Jumping from testwithpublicip to testwithoutpublicip, via ssh
    * Copy keypari from local to EC2
    * scp -i "wwang2test.pem" "wwang2test.pem" ec2-user@13.218.22.106:~/
- Test ping 1.1.1.1 from testwithoutpublicip, Fail
- Test ping 1.1.1.1 from testwithpublicip, Success
- Create private subnet .. (optional)
- 
- Create automatically VPC with 2 public, and 2 private, NAT gateway in 1 AZ. 
- Create peering connections, between above VPC. accepted
- Update route table, and see 2 EC2 in two VPCs can ping to each other. (Update SG to allow ICMP on both Subnets)
- Delete  peering connections
- 
- Create Transit gateway (wait few seconds)
- Create Transit gateway attachments on both above VPCs (wait few seconds)
- Do ping test
- Delete TGW
- 
- Delete VPCs
