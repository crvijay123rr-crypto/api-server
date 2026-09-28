#!/usr/bin/env sh
set -eu

: "${PORT:?Heroku PORT is required}"
: "${TELEGRAM_API_ID:?TELEGRAM_API_ID is required}"
: "${TELEGRAM_API_HASH:?TELEGRAM_API_HASH is required}"

export TELEGRAM_WORK_DIR="/tmp/telegram-bot-api"
export TELEGRAM_TEMP_DIR="/tmp/telegram-bot-api-temp"

mkdir -p "$TELEGRAM_WORK_DIR" "$TELEGRAM_TEMP_DIR"

/usr/local/bin/telegram-bot-api \
    --dir="$TELEGRAM_WORK_DIR" \
    --temp-dir="$TELEGRAM_TEMP_DIR" \
    --http-port=8081 \
    --http-ip-address=127.0.0.1 \
    --local &
api_pid=$!

envsubst '${PORT}' < /etc/nginx/http.d/default.conf.template > /etc/nginx/http.d/default.conf
nginx -t
nginx -g 'daemon off;' &
nginx_pid=$!

cleanup() {
    kill "$api_pid" "$nginx_pid" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

while kill -0 "$api_pid" 2>/dev/null && kill -0 "$nginx_pid" 2>/dev/null; do
    sleep 2
done

exit 1
