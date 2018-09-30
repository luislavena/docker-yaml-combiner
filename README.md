# yaml-combiner

Minimal YAML merging tool.

Perform simple combination of multiple YAML source files into a single
output, merging Hash keys and combining Arrays into unique elements.

## Usage

Simply run using `docker run`:

```shell
$ docker run -it --rm luislavena/yaml-combiner --help
```

This will output the default available options of the program. You will
require exposing files using volumes in order for this to be usable.

### Volumes

This container uses `/data` as default work directory, which you can mount
to expose your local YAML files to it:

```shell
$ docker run -it -v $(pwd):/data luislavena/yaml-combiner in1.yml in2.yml
```

By default the combined YAML will be sent to STDOUT, but you can change it to
be send on into a file on the same directory:

```shell
$ docker run -it -v $(pwd):/data luislavena/yaml-combiner --output out.yml in1.yml in2.yml
```

## Sponsor

Work on this was made possible thanks to [AREA 17](https://area17.com).

## License

All code contained in this repository, unless explicitly stated, is
licensed under MIT license.

A copy of the license can be found inside the [LICENSE](LICENSE) file.
