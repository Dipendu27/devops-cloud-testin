# Simple API Health Check
RESPONSE=$(curl -o /dev/null -s -w "%{http_code}\n" https://api.github.com)

if [ "$RESPONSE" = "200" ]; then
    echo "API is UP! Status: $RESPONSE"
else
    echo "API is DOWN! Status: $RESPONSE"
fi
