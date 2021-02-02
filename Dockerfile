FROM alpine:3.13

# default data directory
WORKDIR /data

# install ruby and dependencies
RUN set -eux; \
    apk add --no-cache \
      ruby \
      tini \
    ;

COPY bin/yaml-combiner /usr/bin/yaml-combiner

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/yaml-combiner"]
CMD ["--help"]
