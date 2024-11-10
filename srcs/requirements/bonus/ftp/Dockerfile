FROM debian:bullseye

ARG FTP_USER
ARG FTP_PASS

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y vsftpd procps net-tools && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/vsftpd/empty && \
    chmod 755 /var/run/vsftpd/empty && \
    mkdir -p /web_data && \
    chmod 755 /web_data

# add FTP user and set permissions
RUN useradd -m -d /web_data -G www-data ${FTP_USER} && \
    chown -R ${FTP_USER}:www-data /web_data && \
    echo "${FTP_USER}:${FTP_PASS}" | chpasswd && \
    chmod 755 /web_data

# create log files and set permissions
RUN touch /var/log/vsftpd.log && \
    chmod 644 /var/log/vsftpd.log

COPY vsftpd.conf /etc/vsftpd.conf
RUN chmod 644 /etc/vsftpd.conf

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 20 21 30000-30100

CMD ["/start.sh"]