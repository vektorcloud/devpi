FROM alpine:latest

ENV DEVPI_SERVERDIR /mnt DEVPI_CLIENTDIR /tmp/devpi-client

RUN apk add --update python && \
    apk add wget ca-certificates && \
    wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python && \
    apk del wget ca-certificates && \
    rm /var/cache/apk/*

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

VOLUME /mnt
EXPOSE 3141
COPY run.sh /run.sh
CMD /bin/bash /run.sh
