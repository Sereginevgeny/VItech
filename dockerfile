FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y wget git unzip && \
    rm -rf /var/lib/apt/lists/*

COPY /etc/crontab /etc/crontab

CMD ["cat", "/etc/crontab"]
