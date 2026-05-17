#!/bin/bash

DATA_FILE="ubuy_inventory.json"
echo "Starting Full Inventory Scan..."
echo "-------------------------------"

# 1. Ask jq how many products are in the array
TOTAL_ITEMS=$(cat $DATA_FILE | jq '.products | length')

# 2. Start a loop from 0 to (TOTAL_ITEMS - 1)
for (( i=0; i<$TOTAL_ITEMS; i++ ))
do
    # Use the variable $i to dynamically change the index
    NAME=$(cat $DATA_FILE | jq -r ".products[$i].name")
    STOCK=$(cat $DATA_FILE | jq -r ".products[$i].stock")

    # 3. Check the stock for the current item
    if [ "$STOCK" -eq 0 ]; then
        echo "❌ ALERT: $NAME is out of stock!"
    else
        echo "✅ OK: $NAME is in stock (Qty: $STOCK)."
    fi
done

echo "-------------------------------"
echo "Scan Complete."
