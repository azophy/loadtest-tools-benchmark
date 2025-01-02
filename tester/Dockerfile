FROM node:alpine

ARG VEGETA_DOWNLOAD_URL=https://github.com/tsenart/vegeta/releases/download/v12.11.1/vegeta_12.11.1_linux_amd64.tar.gz
ARG CASSOWARY_DOWNLOAD_URL=https://github.com/rogerwelin/cassowary/releases/download/v0.16.0/cassowary_Linux_x86_64.tar.gz
ARG K6_DOWNLOAD_URL=https://github.com/grafana/k6/releases/download/v0.49.0/k6-v0.49.0-linux-amd64.tar.gz
ARG DRILL_DOWNLOAD_URL=https://github.com/fcsonline/drill/releases/download/0.8.3/drill_0.8.3_x86_64-unknown-linux-musl.tar.gz
ARG GO_DOWNLOAD_URL=https://go.dev/dl/go1.22.0.linux-amd64.tar.gz

RUN npm install -g artillery
RUN npm install -g autocannon

RUN apk update && apk add wrk
RUN wget -qO- $VEGETA_DOWNLOAD_URL | tar xvzf -  -C /usr/local/bin
RUN wget -qO- $CASSOWARY_DOWNLOAD_URL | tar xvzf -  -C /usr/local/bin
RUN wget -qO- $DRILL_DOWNLOAD_URL | tar xvzf -  -C /usr/local/bin
RUN wget -qO- $K6_DOWNLOAD_URL | tar xvzf - -C /tmp \
 && mv /tmp/k6*/* /usr/local/bin/

ENV PATH="${PATH}:/usr/local/go/bin"
RUN wget -qO- $GO_DOWNLOAD_URL | tar xvzf - -C /usr/local \
 && go install github.com/vearutop/plt@latest \
 && go install github.com/tsliwowicz/go-wrk@latest

# install wrk2
RUN wget https://github.com/giltene/wrk2/archive/refs/heads/master.zip \
 && unzip master.zip \
 && apk add alpine-sdk openssl-dev zlib-dev \
 && make -C wrk2-master \
 && mv wrk2-master/wrk /usr/local/bin/wrk2

# install bun. ref: https://github.com/oven-sh/bun/issues/5545#issuecomment-1722326196
RUN apk --no-cache add ca-certificates wget \
 && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
 && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk \
 && apk add --no-cache --force-overwrite glibc-2.28-r0.apk \
 && npm install -g bun

