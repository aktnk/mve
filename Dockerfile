ARG ALPINE_VERSION=3.12
FROM alpine:${ALPINE_VERSION}

ARG TIMEZONE=Asia/Tokyo
RUN apk add --no-cache tzdata \
        doas \
        make \
        g++ \
        jpeg-dev \
        libpng-dev \
        tiff-dev \
        mesa-dev && \
    cp  /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    apk del tzdata && \
    rm -rf /var/cache/apk/* && \
    addgroup -S mve && \    
    adduser -S mve -D -G mve -h /mve

COPY . /mve
WORKDIR /mve

RUN mkdir bin && \
    make -j"$(nproc)" all && \
    make container_links && \
    chown -R mve:mve /mve

USER mve

