FROM debian:bullseye

ARG FTP_USER
ARG FTP_PASS

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y vsftpd

RUN mkdir -p /var/run/vsftpd/empty && \
    chmod 755 /var/run/vsftpd/empty && \
    mkdir -p /web_data && \
    chmod 755 /web_data

# add FTP user and set permissions
RUN useradd -m -d /web_data -G www-data ${FTP_USER} && \
    chown -R www-data:www-data /web_data && \
    echo "${FTP_USER}:${FTP_PASS}" | chpasswd && \
    chmod 755 /web_data

COPY vsftpd.conf /etc/vsftpd.conf
RUN chmod 644 /etc/vsftpd.conf

EXPOSE 20 21 30000-30100

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]