#!/bin/bash

# --- CONFIGURATION ---
BUCKET_NAME="dipendu-qa-test-artifacts"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="inventory_run_${TIMESTAMP}.log"

echo "=========================================="
echo "🚀 [AWS Cloud Orchestration] Starting Automated Run"
echo "⏰ Timestamp: $TIMESTAMP"
echo "=========================================="

# 1. Execute the core Docker test tool and dump output directly into the timestamped log
echo "📦 Running test suite inside Docker container..."
docker run cloud-tester bash inventory_check.sh > "$LOG_FILE" 2>&1

# Capture the exit status of the test suite execution
TEST_EXIT_CODE=$?

echo "📝 Test execution finished. Log file generated: $LOG_FILE"
echo "------------------------------------------"

# 2. Upload the generated artifact to the secure S3 Bucket
echo "☁️ Archiving artifacts to Amazon S3..."
aws s3 cp "$LOG_FILE" "s3://${BUCKET_NAME}/logs/${LOG_FILE}"

if [ $? -eq 0 ]; then
    echo "✅ SUCCESS: Log archived safely to s3://${BUCKET_NAME}/logs/"
else
    echo "❌ ERROR: Cloud archive upload failed!"
fi

echo "=========================================="
echo "🏁 Execution complete. Tearing down run session."
echo "=========================================="

# Exit with the original test status so CI/CD processes can interpret failures
exit $TEST_EXIT_CODE
