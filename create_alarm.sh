#!/bin/bash
aws cloudwatch put-metric-alarm \
  --alarm-name "EC2-High-CPU" \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --dimensions Name=InstanceId,Value=i-0548954f1883299aa \
  --evaluation-periods 2 \
  --region ap-south-1
