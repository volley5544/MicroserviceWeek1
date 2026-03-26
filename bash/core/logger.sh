#!/bin/bash

LOG_FILE="./storage/logs/app.log"

log_write() {
  level="$1"
  message="$2"
  meta="$3"
  data="$4"

  timestamp=$(date +"%Y%m%dT%H:%M:%S%:z")

  # generate trace_id (simple version)
  trace_id="$(openssl rand -hex 8),$(openssl rand -hex 8)"

  # fallback empty objects
  [ -z "$meta" ] && meta="{}"
  [ -z "$data" ] && data="{}"

  log=$(cat <<EOF
{
  "timestamp": "$timestamp",
  "message": "$message",
  "level": "$level",
  "trace_id": "$trace_id",
  "service": "users-api",
  "meta_data": $meta,
  "data": $data
}
EOF
)

  echo "$log" >> "$LOG_FILE"
}

log_info() {
  log_write "INFO" "$1" "$2" "$3"
}

log_error() {
  log_write "ERROR" "$1" "$2" "$3"
}