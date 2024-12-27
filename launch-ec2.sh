#!/bin/bash

# Enable debug mode to show the commands being executed
set -x

# Set AWS region and security group/key pair
REGION="us-east-1"
SECURITY_GROUP="sg-074b393c038227f9e"  # Replace with your actual security group ID
KEY_PAIR="demo"  # Just the name of the key pair, not the .pem file
INSTANCE_TYPE="t2.micro"  # Example instance type, adjust as needed

 # Set AWS credentials (Make sure to store them securely)
export AWS_ACCESS_KEY_ID="AKIAVRUVVR5ISFUIGMOR"
export AWS_SECRET_ACCESS_KEY="aOjQ1+ckLtXHtJnJ36ZodT6uM+akTsr7SKSYBxtu"
export AWS_DEFAULT_REGION="$REGION"

# Generate a random name for the instance
INSTANCE_NAME="Instance-$(date +%s)-$RANDOM"

# Launch EC2 instance with random name and other parameters
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id ami-01816d07b1128cd2d \
  --count 1 \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_PAIR \
  --security-group-ids $SECURITY_GROUP \
  --region $REGION \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
  --query "Instances[0].InstanceId" \
  --output text)

# Output the instance ID and the instance name
echo "Launched EC2 instance with ID: $INSTANCE_ID"
echo "Instance name: $INSTANCE_NAME"

# Save the Instance ID to a file for future use
echo $INSTANCE_ID > instance_id.txt
