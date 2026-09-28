FROM aiogram/telegram-bot-api:latest

USER root

# Ensure the user/group expected by the Telegram Bot API entrypoint exists
RUN addgroup -S telegram-bot-api \
    && adduser -S -D -H -G telegram-bot-api telegram-bot-api

COPY start-heroku.sh /start-heroku.sh
RUN chmod +x /start-heroku.sh

ENTRYPOINT ["/start-heroku.sh"]
