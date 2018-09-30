#!/usr/bin/env bats

IMAGE=${IMAGE:-luislavena/yaml-combiner:latest}
DOCKER_CMD="docker run -it --rm ${IMAGE}"

@test "check executable works" {
	run $DOCKER_CMD --version
	[ "$status" -eq 0 ]
	[[ "$output" =~ "yaml-combiner version" ]]
}
