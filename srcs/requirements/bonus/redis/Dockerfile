FROM debian:bullseye

# install redis
RUN apt update && apt upgrade -y && apt install -y \
    redis-server && \
    rm -rf /var/lib/apt/lists/* # remove temp files

EXPOSE 6379

CMD ["redis-server", "--bind", "0.0.0.0", "--port", "6379", "--protected-mode no", "--daemonize no"]