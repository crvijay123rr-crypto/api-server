FROM aiogram/telegram-bot-api:latest

USER root

RUN apk add --no-cache nginx gettext

COPY nginx.conf.template /etc/nginx/http.d/default.conf.template
COPY start-heroku.sh /start-heroku.sh
RUN chmod +x /start-heroku.sh

ENTRYPOINT ["/start-heroku.sh"]
