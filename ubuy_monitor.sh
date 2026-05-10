#!/bin/bash

# ============================================================
# ubuy_monitor.sh — E-Commerce Endpoint Health & Price Monitor
# Author: Dipendu Mukherjee
# Project: devops-cloud-testing
# ============================================================

# --- CONFIG ---
BASE_URL="https://www.ubuy.co.in"
LOG_FILE="ubuy_monitor.log"
ALERT_LOG="ubuy_alerts.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Product endpoints to test (simulating real category pages)
ENDPOINTS=(
  "/category/laptops-21457"
  "/brand/3m"
  "/category/keyboards-14289"
)

# --- FUNCTIONS ---

log() {
  echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

alert() {
  echo "[$TIMESTAMP] ALERT: $1" | tee -a "$ALERT_LOG"
}

check_endpoint() {
  local path=$1
  local full_url="${BASE_URL}${path}"
  local http_code

  http_code=$(curl -s -o /dev/null -w "%{http_code}" \
    --max-time 10 \
    -L \
    --user-agent "Mozilla/5.0 (QA-Monitor-Bot)" \
    "$full_url")

  if [ "$http_code" -eq 200 ]; then
    log "OK [$http_code] — $full_url"
  elif [ "$http_code" -eq 301 ] || [ "$http_code" -eq 302 ]; then
    log "REDIRECT [$http_code] — $full_url (Following redirect...)"
  elif [ "$http_code" -eq 403 ] || [ "$http_code" -eq 429 ]; then
    alert "BLOCKED [$http_code] — $full_url (Bot protection triggered)"
  elif [ "$http_code" -eq 404 ]; then
    alert "NOT FOUND [$http_code] — $full_url (Endpoint removed?)"
  else
    alert "UNEXPECTED [$http_code] — $full_url"
  fi
}

# --- MAIN ---

log "====== Ubuy Monitor Run Started ======"

# Loop through all endpoints
for endpoint in "${ENDPOINTS[@]}"; do
  check_endpoint "$endpoint"
  sleep 2  # Polite delay — avoid hammering the server
done

log "====== Run Complete ======"