ARG ALPINE_VERSION=3.12
FROM alpine:${ALPINE_VERSION}

COPY . /mve

RUN apk add --no-cache \
        make \
        g++ \
        jpeg-dev \
        libpng-dev \
        tiff-dev \
        mesa-dev \
    && cd /mve \
    && mkdir bin \
    && make -j"$(nproc)" all

