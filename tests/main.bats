#!/usr/bin/env bats

IMAGE=${IMAGE:-luislavena/yaml-combiner:latest}
DOCKER_CMD="docker run -it --rm -v $(pwd):/data ${IMAGE}"
FIXTURES_PATH="tests/fixtures"

@test "check executable works" {
	run $DOCKER_CMD --version
	[ "$status" -eq 0 ]
	[[ "$output" =~ "yaml-combiner version" ]]
}

@test "check basic merging" {
	run $DOCKER_CMD $FIXTURES_PATH/basic/in1.yml $FIXTURES_PATH/basic/in2.yml
	[ "$status" -eq 0 ]
	[[ "$output" = "`cat $FIXTURES_PATH/basic/out.yml`" ]]
}

@test "check array merging works" {
	run $DOCKER_CMD $FIXTURES_PATH/array/in1.yml $FIXTURES_PATH/array/in2.yml
	[ "$status" -eq 0 ]
	[[ "$output" = "`cat $FIXTURES_PATH/array/out.yml`" ]]
}

@test "check hash merging works" {
	run $DOCKER_CMD $FIXTURES_PATH/hash/in1.yml $FIXTURES_PATH/hash/in2.yml
	[ "$status" -eq 0 ]
	[[ "$output" = "`cat $FIXTURES_PATH/hash/out.yml`" ]]
}

@test "check message works" {
	run $DOCKER_CMD --message "This is my message" $FIXTURES_PATH/message/in.yml
	[ "$status" -eq 0 ]
	[[ "$output" =~ "This is my message" ]]
}
