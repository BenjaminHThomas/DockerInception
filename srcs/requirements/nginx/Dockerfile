FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y \
	nginx \
	openssl

RUN mkdir -p /etc/ssl/private && \
    mkdir -p /etc/ssl/certs && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/ssl/private/server.key \
        -out /etc/ssl/certs/server.crt \
        -subj "/CN=bthomas.42.fr"

COPY default.conf /etc/nginx/sites-available/nginx.conf
COPY ./startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/startup.sh"]
CMD ["nginx", "-g", "daemon off;"]
