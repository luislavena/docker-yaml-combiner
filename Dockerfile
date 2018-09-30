FROM alpine:3.8

# default data directory
WORKDIR /data

# install ruby dependencies
RUN set -ex \
        && apk add --no-cache \
                ruby

COPY src/yaml-combiner.rb /usr/bin/yaml-combiner
RUN set -ex \
        && chmod +x /usr/bin/yaml-combiner

ENTRYPOINT ["/usr/bin/yaml-combiner"]
