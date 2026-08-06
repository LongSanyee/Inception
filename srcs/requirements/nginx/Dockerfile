FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/CN=rammisse.42.fr"

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

COPY tools/nginx.sh nginx.sh

RUN chmod +x nginx.sh

EXPOSE 443

ENTRYPOINT ["./nginx.sh"]