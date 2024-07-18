FROM nginx

COPY ./server/mini_server.c /home
RUN apt update && apt install -y gcc libfcgi-dev spawn-fcgi \
    && gcc /home/mini_server.c -o mini_server -lfcgi; \
    chown -R nginx:nginx /etc/nginx/nginx.conf; \
    chown -R nginx:nginx /var/cache/nginx; \
    chown -R nginx:nginx /home; \
    touch /var/run/nginx.pid; \
    chown -R nginx:nginx /var/run/nginx.pid; \
    rm -rf /var/lib/apt/lists

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

USER nginx
ENTRYPOINT spawn-fcgi -p 8080 ./mini_server && nginx -g "daemon off;"
