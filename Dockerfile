FROM resin/raspberrypi2-node:5.7.1-slim

ENV KIBANA_VERSION 4.5.0-linux-x64
ENV NODE_VERSION 5.7.1

RUN apt-get update && \
  apt-get install -y wget ca-certificates && \
  mkdir -p /opt && \
  wget -q https://download.elasticsearch.org/kibana/kibana/kibana-${KIBANA_VERSION}.tar.gz && \
  tar -C /opt -xzf kibana-${KIBANA_VERSION}.tar.gz && \
  rm kibana-${KIBANA_VERSION}.tar.gz && \
  rm -rf /opt/kibana-${KIBANA_VERSION}/node && \
  mkdir -p /opt/kibana-${KIBANA_VERSION}/node/bin && \
  ln -sf /usr/bin/node /opt/kibana-${KIBANA_VERSION}/node/bin/node && \
  apt-get remove -y wget ca-certificates && \
  apt-get clean && \
  rm -rf /var/apt/lists/* /tmp/* /var/tmp/*

ADD ./run.sh /run.sh

EXPOSE 5601

ENTRYPOINT /run.sh
