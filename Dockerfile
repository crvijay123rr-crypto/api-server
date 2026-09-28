FROM aiogram/telegram-bot-api:latest

USER root

# Make sure telegram-bot-api group exists
RUN if ! grep -q '^telegram-bot-api:' /etc/group; then \
        addgroup -g 101 -S telegram-bot-api; \
    fi

# Make sure telegram-bot-api user exists
RUN if ! grep -q '^telegram-bot-api:' /etc/passwd; then \
        adduser -S -D -H \
        -u 101 \
        -h /var/lib/telegram-bot-api \
        -s /sbin/nologin \
        -G telegram-bot-api \
        -g telegram-bot-api \
        telegram-bot-api; \
    fi

# Verify user and group
RUN id telegram-bot-api && grep '^telegram-bot-api:' /etc/group

COPY start-heroku.sh /start-heroku.sh
RUN chmod +x /start-heroku.sh

ENTRYPOINT ["/start-heroku.sh"]
