FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt install -y \
	nginx \
	openssl

RUN mkdir -p /etc/ssl/private && \
    mkdir -p /etc/ssl/certs && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/ssl/private/server.key \
        -out /etc/ssl/certs/server.crt \
        -subj "/CN=localhost"

COPY default /etc/nginx/sites-available/.

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
