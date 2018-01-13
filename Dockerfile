# devpi has issues running with musl, use glibc
FROM quay.io/vektorcloud/glibc:latest

ENV DEVPI_SERVERDIR /devpi

RUN apk add --no-cache python3 python3-dev py3-cffi curl && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip

COPY requirements.txt /requirements.txt
RUN apk add --no-cache gcc musl-dev && \
    pip install --no-cache-dir -r /requirements.txt && \
    apk del gcc

COPY run.sh /run.sh

EXPOSE 3141
VOLUME /devpi
HEALTHCHECK --interval=30s --retries=3 --start-period=3s \
  CMD /run.sh health
ENTRYPOINT ["/run.sh"]
