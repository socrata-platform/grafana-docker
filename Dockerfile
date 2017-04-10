FROM socrata/runit

ENV GRAFANA_VERSION 4.2.0

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get -y install libfontconfig wget adduser openssl ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_${GRAFANA_VERSION}_amd64.deb -O /tmp/grafana.deb && \
    dpkg -i /tmp/grafana.deb && \
    rm /tmp/grafana.deb

EXPOSE 3000

# Service setup
RUN mkdir /etc/service/grafana
COPY sv/grafana-run /etc/service/grafana/run