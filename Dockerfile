ARG ALPINE_VERSION=3.12
FROM alpine:${ALPINE_VERSION}

COPY . /mve
WORKDIR /mve

ENV HOME=/mve
ENV PATH=$PATH:$HOME/bin

RUN apk add --no-cache \
        make \
        g++ \
        jpeg-dev \
        libpng-dev \
        tiff-dev \
        mesa-dev \
    && mkdir bin \
    && make -j"$(nproc)" all \
    && make container_links

