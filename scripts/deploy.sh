#!/usr/bin/env bash
set -e

# login into Docker Hub
echo Docker Hub login...
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# push image
echo Pushing $IMAGE...
docker push $IMAGE
