FROM alpine:3.13

# default data directory
WORKDIR /data

# install ruby and dependencies
RUN set -eux; \
    apk add --no-cache \
      ruby

COPY bin/yaml-combiner /usr/bin/yaml-combiner

ENTRYPOINT ["/usr/bin/yaml-combiner"]
CMD ["--help"]
