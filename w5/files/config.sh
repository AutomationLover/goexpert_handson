#!/bin/bash
set -e
PROFILE_NAME=tutorial
CLUSTER_NAME=tutorial-cluster
REGION=us-west-2
LAUNCH_TYPE=EC2
ecs-cli configure profile --profile-name "$PROFILE_NAME"
ecs-cli configure --cluster "$CLUSTER_NAME" --default-launch-type "$LAUNCH_TYPE" --region "$REGION" --config-name "$PROFILE_NAME"
