#!/bin/bash

set -e

echo "Starting helicopterizer..."


if [ "${1:0:1}" = '-' ]; then
	set -- docker "$@"
fi

# if our command is a valid Docker subcommand, let's invoke it through Docker instead
# (this allows for "docker run docker ps", etc)
if docker "$1" --help > /dev/null 2>&1; then
	set -- docker "$@"
fi

# if we have "--link some-docker:docker" and not DOCKER_HOST, let's set DOCKER_HOST automatically
if [ -z "$DOCKER_HOST" -a "$DOCKER_PORT_2375_TCP" ]; then
	export DOCKER_HOST='tcp://docker:2375'
fi

if [ "$DATA_PATH" ]; then
    export DATA_PATH=${DATA_PATH:-$DATA_PATH}
else
    export DATA_PATH=${DATA_PATH:-/data/}
fi

export DATA_PATH=${DATA_PATH:-/data/}

: ${AWS_ACCESS_KEY_ID:?"Environment variable AWS_ACCESS_KEY_ID is required!"}
: ${AWS_SECRET_ACCESS_KEY:?"Environment variable AWS_SECRET_ACCESS_KEY is required!"}
: ${AWS_DEFAULT_REGION:?"Environment variable AWS_DEFAULT_REGION is required!"}
: ${AWS_S3_PATH:?"Environment variable AWS_S3_PATH is required!"}

echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
echo "AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION"
echo "AWS_S3_PATH=$AWS_S3_PATH"

case $1 in

    backup)
        exec /backup-s3.sh
        ;;

    restore)
        exec /restore-s3.sh
        ;;

    *)
        echo "Error: Invalid Parameter"
        exit 1
esac