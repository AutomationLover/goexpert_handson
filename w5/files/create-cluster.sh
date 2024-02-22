#!/bin/bash
KEY_PAIR=MyKeyPair
    ecs-cli up \
      --keypair $KEY_PAIR  \
      --capability-iam \
      --size 1 \
      --instance-type t3.micro \
      --tags project=my-cluster,owner=william \
      --cluster-config tutorial \
      --ecs-profile tutorial
