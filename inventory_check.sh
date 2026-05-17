#!/bin/bash

# Target file (in a real scenario, this would be a curl command to an API)
DATA_FILE="ubuy_inventory.json"

echo "Running API JSON Validation..."

# Extract the stock value of the Air Jordans (Index 1)
# The -r flag gives us "raw" output without quotation marks
STOCK=$(cat $DATA_FILE | jq -r '.products[1].stock')
ITEM_NAME=$(cat $DATA_FILE | jq -r '.products[1].name')

# Conditional Logic: If stock is 0, fail the test
if [ "$STOCK" -eq 0 ]; then
    echo "❌ CRITICAL ALERT: $ITEM_NAME is out of stock! (Stock: $STOCK)"
    exit 1
else
    echo "✅ SUCCESS: $ITEM_NAME is in stock. (Stock: $STOCK)"
    exit 0
fi