#!/usr/bin/env sh
set -eu

export TELEGRAM_HTTP_PORT="${PORT:-8081}"
export TELEGRAM_HTTP_IP_ADDRESS="0.0.0.0"
export TELEGRAM_LOCAL="1"
export TELEGRAM_WORK_DIR="/tmp/telegram-bot-api"
export TELEGRAM_TEMP_DIR="/tmp/telegram-bot-api-temp"

mkdir -p "$TELEGRAM_WORK_DIR" "$TELEGRAM_TEMP_DIR"

exec /usr/local/bin/telegram-bot-api \
    --dir="$TELEGRAM_WORK_DIR" \
    --temp-dir="$TELEGRAM_TEMP_DIR" \
    --http-port="$TELEGRAM_HTTP_PORT" \
    --http-ip-address="$TELEGRAM_HTTP_IP_ADDRESS" \
    --local
