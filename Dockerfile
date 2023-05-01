ARG ALPINE_VERSION=3.12
FROM alpine:${ALPINE_VERSION}

ARG TIMEZONE=Asia/Tokyo
RUN apk add --no-cache tzdata \
        make \
        g++ \
        jpeg-dev \
        libpng-dev \
        tiff-dev \
        mesa-dev && \
    cp  /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

COPY . /mve
WORKDIR /mve
ENV HOME=/mve

RUN mkdir bin \
    && make -j"$(nproc)" all \
    && make container_links

ENV PATH=$PATH:$HOME/bin
