#!/bin/bash

# Define the URL
URL="https://www.a.ubuy.com.kw/en/"

# Use 'curl' to get the HTTP status code
# 200 means OK, 404 means Not Found
STATUS=$(curl -o /dev/null -s -w "%{http_code}" $URL)

if [ $STATUS -eq 200 ]; then
  echo "SUCCESS: $URL is up and running! (Status: $STATUS)"
else
  echo "FAILURE: $URL might be down! (Status: $STATUS)"
fi
