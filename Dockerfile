FROM socrata/runit

ENV GRAFANA_VERSION 2.5.0

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get -y install libfontconfig wget adduser openssl ca-certificates && \
    apt-get clean && \
    wget https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb -O /tmp/grafana.deb && \
    dpkg -i /tmp/grafana.deb && \
    rm /tmp/grafana.deb

EXPOSE 3000

RUN mkdir /etc/service/grafana
ADD service/grafana-run /etc/service/grafana/run
ADD service/grafana-log /etc/service/grafana/log
