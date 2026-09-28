FROM aiogram/telegram-bot-api:latest

USER root

COPY start-heroku.sh /start-heroku.sh
RUN chmod +x /start-heroku.sh

ENTRYPOINT ["/start-heroku.sh"]
