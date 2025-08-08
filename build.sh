#!/usr/bin/env bash
set -euxo pipefail

tag=${tag:-}  # optional tag from env

# Build to extract deb files locally (no image created)
docker buildx build \
  --output type=local,dest=./dist \
  $( [ -n "$OLD_CODENAME" ] && echo "--build-arg OLD_CODENAME=$OLD_CODENAME" ) \
  $( [ -n "$NEW_CODENAME" ] && echo "--build-arg NEW_CODENAME=$NEW_CODENAME" ) \
  $( [ -n "$PACKAGE" ] && echo "--build-arg PACKAGE=$PACKAGE" ) \
  .

# Build and push the image if tag is set
if [ -n "$tag" ]; then
  docker buildx build --push -t "$tag" \
    $( [ -n "$OLD_CODENAME" ] && echo "--build-arg OLD_CODENAME=$OLD_CODENAME" ) \
    $( [ -n "$NEW_CODENAME" ] && echo "--build-arg NEW_CODENAME=$NEW_CODENAME" ) \
    $( [ -n "$PACKAGE" ] && echo "--build-arg PACKAGE=$PACKAGE" ) \
    .
fi

