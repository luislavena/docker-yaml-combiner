FROM alpine:3.13

# default data directory
WORKDIR /data

# install ruby and dependencies
RUN set -eux; \
    apk add --no-cache \
      ruby

COPY src/yaml-combiner.rb /usr/bin/yaml-combiner
RUN set -ex \
        && chmod +x /usr/bin/yaml-combiner

ENTRYPOINT ["/usr/bin/yaml-combiner"]
