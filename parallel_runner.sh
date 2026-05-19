#!/bin/bash

BUCKET_NAME="${BUCKET_NAME:-dipendu-qa-test-artifacts}"
IMAGE_NAME="${IMAGE_NAME:-ubuy-monitor-app}"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
MONITOR_LOG="monitor_run_${TIMESTAMP}.log"
INVENTORY_LOG="inventory_run_${TIMESTAMP}.log"

echo "=========================================="
echo "⚡ [High-Performance DevOps] Launching Parallel Test Matrix"
echo "⏰ Start Time: $(date)"
echo "=========================================="

# 1. Start the Ubuy Monitor in the BACKGROUND using '&'
echo "🌐 Launching live web monitor suite..."
docker run "$IMAGE_NAME" bash ubuy_monitor.sh > "$MONITOR_LOG" 2>&1 &
PID_MONITOR=$! # Capture the unique Process ID (PID) of this background job
echo "   [Background Job Started] PID: $PID_MONITOR"

# 2. Start the JSON Inventory Check in the BACKGROUND at the exact same time
echo "📦 Launching dynamic JSON validation suite..."
docker run "$IMAGE_NAME" bash inventory_check.sh > "$INVENTORY_LOG" 2>&1 &
PID_INVENTORY=$! # Capture the unique Process ID of this background job
echo "   [Background Job Started] PID: $PID_INVENTORY"

echo "------------------------------------------"
echo "⏳ Waiting for all background pipelines to complete execution..."
echo "------------------------------------------"

# 3. The Wait Barrier: Pause the script until BOTH background processes finish
wait "$PID_MONITOR"
STATUS_MONITOR=$?
echo "✅ Monitor Suite finished (Exit Code: $STATUS_MONITOR)"

wait "$PID_INVENTORY"
STATUS_INVENTORY=$?
echo "✅ Inventory Suite finished (Exit Code: $STATUS_INVENTORY)"

echo "------------------------------------------"
echo "☁️ Executing multi-stream archival to Amazon S3..."

# 4. Upload logs concurrently
aws s3 cp "$MONITOR_LOG" "s3://${BUCKET_NAME}/logs/$MONITOR_LOG" &
PID_UPLOAD_MONITOR=$!
aws s3 cp "$INVENTORY_LOG" "s3://${BUCKET_NAME}/logs/$INVENTORY_LOG" &
PID_UPLOAD_INVENTORY=$!

# Wait for uploads to clear
wait "$PID_UPLOAD_MONITOR"
STATUS_UPLOAD_MONITOR=$?
wait "$PID_UPLOAD_INVENTORY"
STATUS_UPLOAD_INVENTORY=$?

echo "=========================================="
echo "🏁 Matrix Scan Complete. Total execution time optimized."
echo "=========================================="

if [ "$STATUS_MONITOR" -ne 0 ] || [ "$STATUS_INVENTORY" -ne 0 ] || [ "$STATUS_UPLOAD_MONITOR" -ne 0 ] || [ "$STATUS_UPLOAD_INVENTORY" -ne 0 ]; then
    exit 1
fi

exit 0
