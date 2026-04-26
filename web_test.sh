#!/bin/bash

URL="http://jkhfkvjdhsk.com"  # This is a fake URL for testing purposes

# This command gets ONLY the status code (e.g., 200)
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

if [ "$STATUS" -eq 200 ]; then
    echo "✅ TEST PASSED: $URL is healthy (Status: $STATUS)"
else
    echo "❌ TEST FAILED: $URL returned $STATUS"
fi