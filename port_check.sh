#!/bin/bash

SERVER="a.ubuy.com.kw"
PORT=443

echo "Checking if $SERVER is accepting connections on port $PORT..."

if nc -zv $SERVER $PORT 2>&1 | grep -q "succeeded"; then
    echo "✅ SUCCESS: Port $PORT is open. We can deploy!"
else
    echo "❌ FAILURE: Port $PORT is closed. Check Firewall/Security Groups."
fi