FROM elixir:alpine

LABEL maintainer "mi2428 <tmiya@protonmail.ch>"

ENV PLEROMA_VERSION="develop"

RUN apk -U upgrade && \
    apk add -t build-dependencies build-base git && \
    rm -rf /tmp/* /var/cache/apk/*

COPY ./entrypoint.sh .
RUN chmod +x ./entrypoint.sh

RUN git clone --progress -b "$PLEROMA_VERSION" https://git.pleroma.social/pleroma/pleroma

WORKDIR /pleroma
RUN mix local.rebar --force && \
    mix local.hex --force && \
    mix deps.get

EXPOSE 4000
VOLUME ["/pleroma/uploads/", "/pleroma/config", "/pleroma/priv/"]
ENTRYPOINT ["/entrypoint.sh"]
