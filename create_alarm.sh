#!/bin/bash
INSTANCE_ID="${INSTANCE_ID:-i-0548954f1883299aa}"
AWS_REGION="${AWS_REGION:-ap-south-1}"

aws cloudwatch put-metric-alarm \
  --alarm-name "EC2-High-CPU" \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --dimensions Name=InstanceId,Value="$INSTANCE_ID" \
  --evaluation-periods 2 \
  --region "$AWS_REGION"

aws cloudwatch put-metric-alarm \
  --alarm-name "EC2-Status-Check-Failed" \
  --metric-name StatusCheckFailed \
  --namespace AWS/EC2 \
  --statistic Maximum \
  --period 60 \
  --threshold 1 \
  --comparison-operator GreaterThanOrEqualToThreshold \
  --dimensions Name=InstanceId,Value="$INSTANCE_ID" \
  --evaluation-periods 1 \
  --region "$AWS_REGION"
