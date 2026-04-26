#!/bin/bash

# --- DevOps Tip: Variables make your tests reusable ---
SITES=("google.com" "www.a.ubuy.com.kw/en/" "this-site-is-fake-123.com")

echo "--- STARTING MULTI-SITE SMOKE TEST ---"

# --- This is a Loop: It repeats the test for every site ---
for SITE in "${SITES[@]}"
do
    echo "Testing $SITE..."
    
    # -c 2 sends only 2 pings to save time
    # -W 1 waits only 1 second for a response
    if ping -c 2 -W 1 "$SITE" > /dev/null 2>&1; then
        echo "✅ PASS: $SITE is alive."
    else
        echo "❌ FAIL: $SITE is unreachable."
    fi
done

echo "--- TEST SUITE COMPLETE ---"