FROM debian:bullseye

ARG FTP_USER
ARG FTP_PASS
ARG FTP_ROOT

# install and delete temp files
RUN apt update && apt upgrade -y && apt install -y \
    vsftpd && \
    rm -rf /var/lib/apt/lists/*

# configure ftp server
RUN mkdir -p /var/run/vsftpd/empty ${FTP_ROOT} && \
    chmod 777 /var/run/vsftpd/empty && \
    chmod 777 ${FTP_ROOT}

# add ftp user and set permissions
RUN useradd -d ${FTP_ROOT} -G www-data ${FTP_USER} && \
    echo "${FTP_USER}:${FTP_PASS}" | chpasswd && \
    chown -R ${FTP_USER}:www-data ${FTP_ROOT}

# copy config file
COPY vsftpd.conf /etc/vsftpd.conf

EXPOSE 20 21 30000-30100

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]