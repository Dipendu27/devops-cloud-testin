#!/bin/bash

# --- DYNAMIC CONFIGURATION WITH FALLBACKS ---
BUCKET_NAME="${TARGET_S3_BUCKET:-${BUCKET_NAME:-dipendu-qa-test-artifacts}}"
ENV_TAG="${ENVIRONMENT_TAG:-logs}"
IMAGE_NAME="${IMAGE_NAME:-ubuy-monitor-app}"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
MONITOR_LOG="monitor_run_${TIMESTAMP}.log"
INVENTORY_LOG="inventory_run_${TIMESTAMP}.log"

echo "=========================================="
echo "⚡ [Enterprise DevOps] Launching Parameterized Test Matrix"
echo "🐳 Docker Image: $IMAGE_NAME"
echo "🌐 Target Cloud Storage: s3://${BUCKET_NAME}/${ENV_TAG}/"
echo "⏰ Start Time: $(date)"
echo "=========================================="

# 1. Launch Web Monitor in Background
docker run "$IMAGE_NAME" bash ubuy_monitor.sh > "$MONITOR_LOG" 2>&1 &
PID_MONITOR=$!
echo "   [Monitor Job Started] PID: $PID_MONITOR"

# 2. Launch JSON Inventory Check in Background
docker run "$IMAGE_NAME" bash inventory_check.sh > "$INVENTORY_LOG" 2>&1 &
PID_INVENTORY=$!
echo "   [Inventory Job Started] PID: $PID_INVENTORY"

wait "$PID_MONITOR"
STATUS_MONITOR=$?
echo "✅ Monitor Suite finished (Exit Code: $STATUS_MONITOR)"

wait "$PID_INVENTORY"
STATUS_INVENTORY=$?
echo "✅ Inventory Suite finished (Exit Code: $STATUS_INVENTORY)"

echo "------------------------------------------"
echo "☁️ Executing dynamic parameter-driven archival to S3..."

# 3. Upload files dynamically using our variables
aws s3 cp "$MONITOR_LOG" "s3://${BUCKET_NAME}/${ENV_TAG}/${MONITOR_LOG}" &
PID_UPLOAD_MONITOR=$!
aws s3 cp "$INVENTORY_LOG" "s3://${BUCKET_NAME}/${ENV_TAG}/${INVENTORY_LOG}" &
PID_UPLOAD_INVENTORY=$!

wait "$PID_UPLOAD_MONITOR"
STATUS_UPLOAD_MONITOR=$?

wait "$PID_UPLOAD_INVENTORY"
STATUS_UPLOAD_INVENTORY=$?

echo "=========================================="
echo "🏁 Execution Complete. Targets isolated cleanly."
echo "=========================================="

if [ "$STATUS_MONITOR" -ne 0 ] || [ "$STATUS_INVENTORY" -ne 0 ] || [ "$STATUS_UPLOAD_MONITOR" -ne 0 ] || [ "$STATUS_UPLOAD_INVENTORY" -ne 0 ]; then
    exit 1
fi

exit 0
