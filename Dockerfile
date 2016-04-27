FROM quay.io/vektorcloud/python:2

ENV DEVPI_SERVERDIR /devpi

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

COPY run.sh /run.sh

EXPOSE 3141
VOLUME /devpi
CMD /bin/bash /run.sh
