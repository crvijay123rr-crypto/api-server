FROM aiogram/telegram-bot-api:latest

USER root

# Make sure the telegram-bot-api group exists
RUN if ! getent group telegram-bot-api >/dev/null 2>&1; then \
        addgroup -g 101 -S telegram-bot-api; \
    fi \
    && if ! id telegram-bot-api >/dev/null 2>&1; then \
        adduser -S -D -H -u 101 \
        -h /var/lib/telegram-bot-api \
        -s /sbin/nologin \
        -G telegram-bot-api \
        -g telegram-bot-api \
        telegram-bot-api; \
    fi

COPY start-heroku.sh /start-heroku.sh
RUN chmod +x /start-heroku.sh

ENTRYPOINT ["/start-heroku.sh"]
