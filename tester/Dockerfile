FROM node:alpine

ARG VEGETA_DOWNLOAD_URL=https://github.com/tsenart/vegeta/releases/download/v12.11.1/vegeta_12.11.1_linux_amd64.tar.gz
ARG CASSOWARY_DOWNLOAD_URL=https://github.com/rogerwelin/cassowary/releases/download/v0.16.0/cassowary_Linux_x86_64.tar.gz
ARG K6_DOWNLOAD_URL=https://github.com/grafana/k6/releases/download/v0.49.0/k6-v0.49.0-linux-amd64.tar.gz
ARG DRILL_DOWNLOAD_URL=https://github.com/fcsonline/drill/releases/download/0.8.3/drill_0.8.3_x86_64-unknown-linux-musl.tar.gz
ARG GO_DOWNLOAD_URL=https://go.dev/dl/go1.22.0.linux-amd64.tar.gz

RUN npm install -g artillery
RUN npm install -g autocannon

RUN apk update && apk add wrk curl
RUN wget -qO- $VEGETA_DOWNLOAD_URL | tar xvzf -  -C /usr/local/bin
RUN wget -qO- $CASSOWARY_DOWNLOAD_URL | tar xvzf -  -C /usr/local/bin
RUN wget -qO- $DRILL_DOWNLOAD_URL | tar xvzf -  -C /usr/local/bin
RUN wget -qO- $K6_DOWNLOAD_URL | tar xvzf - -C /usr/local/bin

ENV PATH="${PATH}:/usr/local/go/bin"
RUN wget -qO- $GO_DOWNLOAD_URL | tar xvzf - -C /usr/local \
 && go install github.com/vearutop/plt@latest
