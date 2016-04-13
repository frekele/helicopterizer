#!/bin/bash

set -e

echo "Starting helicopterizer..."

: ${AWS_ACCESS_KEY_ID:?"Environment variable AWS_ACCESS_KEY_ID is required!"}
: ${AWS_SECRET_ACCESS_KEY:?"Environment variable AWS_SECRET_ACCESS_KEY is required!"}
: ${AWS_DEFAULT_REGION:?"Environment variable AWS_DEFAULT_REGION is required!"}
: ${AWS_S3_BUCKET:?"Environment variable AWS_S3_BUCKET is required!"}
: ${AWS_S3_PATH:?"Environment variable AWS_S3_PATH is required!"}

echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
echo "AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION"
echo "AWS_S3_BUCKET=$AWS_S3_BUCKET"
echo "AWS_S3_PATH=$AWS_S3_PATH"

case $1 in 

    backup)
	exec /run-backup.sh
	;;

    restore)
	exec /run-restore.sh
	;;

    *)
	echo "Error: Invalid Parameter"
	exit 1
esac
