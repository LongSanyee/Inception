FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl


COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

COPY tools/nginx.sh nginx.sh

RUN chmod +x nginx.sh

EXPOSE 443

ENTRYPOINT ["./nginx.sh"]