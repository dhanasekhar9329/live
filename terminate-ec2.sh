#!/bin/bash

# Enable debug mode to show the commands being executed
set -x

# Set AWS region
REGION="us-east-1"

# Retrieve the instance ID from the saved file
INSTANCE_ID=$(cat instance_id.txt)

if [ -z "$INSTANCE_ID" ]; then
  echo "Error: Instance ID is not found."
  exit 1
fi

# Terminate the EC2 instance
aws ec2 terminate-instances \
  --instance-ids $INSTANCE_ID \
  --region $REGION \
  --output text

# Output message
echo "Terminating EC2 instance with ID: $INSTANCE_ID"
