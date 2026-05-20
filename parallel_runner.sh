#!/bin/bash

# --- DYNAMIC CONFIGURATION WITH FALLBACKS ---
# If $TARGET_S3_BUCKET is set externally, use it. Otherwise, default to your bucket.
BUCKET_NAME="${TARGET_S3_BUCKET:-dipendu-qa-test-artifacts}"

# If $ENVIRONMENT_TAG is set externally (e.g., staging, prod), use it. Otherwise, default to "logs".
ENV_TAG="${ENVIRONMENT_TAG:-logs}"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
MONITOR_LOG="monitor_run_${TIMESTAMP}.log"
INVENTORY_LOG="inventory_run_${TIMESTAMP}.log"

echo "=========================================="
echo "⚡ [Enterprise DevOps] Launching Parametrerized Test Matrix"
echo "🌐 Target Cloud Storage: s3://${BUCKET_NAME}/${ENV_TAG}/"
echo "⏰ Start Time: $(date)"
echo "=========================================="

# 1. Launch Web Monitor in Background
docker run cloud-tester bash ubuy_monitor.sh > "$MONITOR_LOG" 2>&1 &
PID_MONITOR=$!

# 2. Launch JSON Inventory Check in Background
docker run cloud-tester bash inventory_check.sh > "$INVENTORY_LOG" 2>&1 &
PID_INVENTORY=$!

wait $PID_MONITOR
STATUS_MONITOR=$?
wait $PID_INVENTORY
STATUS_INVENTORY=$?

echo "------------------------------------------"
echo "☁️ Executing dynamic parameter-driven archival to S3..."

# 3. Upload files dynamically using our variables
aws s3 cp "$MONITOR_LOG" "s3://${BUCKET_NAME}/${ENV_TAG}/${MONITOR_LOG}" &
aws s3 cp "$INVENTORY_LOG" "s3://${BUCKET_NAME}/${ENV_TAG}/${INVENTORY_LOG}" &

wait

echo "=========================================="
echo "🏁 Execution Complete. Targets isolated cleanly."
echo "=========================================="#!/bin/bash

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
MONITOR_LOG="monitor_run_${TIMESTAMP}.log"
INVENTORY_LOG="inventory_run_${TIMESTAMP}.log"

echo "=========================================="
echo "⚡ [High-Performance DevOps] Launching Parallel Test Matrix"
echo "⏰ Start Time: $(date)"
echo "=========================================="

# 1. Start the Ubuy Monitor in the BACKGROUND using '&'
echo "🌐 Launching live web monitor suite..."
docker run cloud-tester bash ubuy_monitor.sh > "$MONITOR_LOG" 2>&1 &
PID_MONITOR=$! # Capture the unique Process ID (PID) of this background job
echo "   [Background Job Started] PID: $PID_MONITOR"

# 2. Start the JSON Inventory Check in the BACKGROUND at the exact same time
echo "📦 Launching dynamic JSON validation suite..."
docker run cloud-tester bash inventory_check.sh > "$INVENTORY_LOG" 2>&1 &
PID_INVENTORY=$! # Capture the unique Process ID of this background job
echo "   [Background Job Started] PID: $PID_INVENTORY"

echo "------------------------------------------"
echo "⏳ Waiting for all background pipelines to complete execution..."
echo "------------------------------------------"

# 3. The Wait Barrier: Pause the script until BOTH background processes finish
wait $PID_MONITOR
STATUS_MONITOR=$?
echo "✅ Monitor Suite finished (Exit Code: $STATUS_MONITOR)"

wait $PID_INVENTORY
STATUS_INVENTORY=$?
echo "✅ Inventory Suite finished (Exit Code: $STATUS_INVENTORY)"

echo "------------------------------------------"
echo "☁️ Executing multi-stream archival to Amazon S3..."

# 4. Upload logs concurrently
aws s3 cp "$MONITOR_LOG" "s3://dipendu-qa-test-artifacts/logs/$MONITOR_LOG" &
aws s3 cp "$INVENTORY_LOG" "s3://dipendu-qa-test-artifacts/logs/$INVENTORY_LOG" &

# Wait for uploads to clear
wait

echo "=========================================="
echo "🏁 Matrix Scan Complete. Total execution time optimized."
echo "=========================================="
