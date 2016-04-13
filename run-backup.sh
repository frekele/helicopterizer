#!/bin/bash

set -e


echo "Exec backup!"

aws s3 ls s3://$AWS_ACCESS_KEY_ID

#Testing
s3Result=$(aws s3 ls s3://$AWS_S3_BUCKET/$AWS_S3_PATH )

printf "s3Result %s \n" "$s3Result"

