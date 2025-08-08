#!/usr/bin/env bash
set -euxo pipefail

args=(--output type=local,dest=./dist)
[ -n "${tag-}" ] && args+=(-t "$tag")

docker buildx build "${args[@]}" .

