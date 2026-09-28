FROM aiogram/telegram-bot-api:latest

COPY start-heroku.sh /start-heroku.sh
RUN chmod +x /start-heroku.sh

ENTRYPOINT ["/start-heroku.sh"]
