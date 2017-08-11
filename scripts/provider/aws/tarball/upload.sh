#!/bin/bash
#
# Upload Tarball to AWS S3
# Author: frekele
#

#Upload tarball to AWS S3.
uploadToS3(){
  local s3Result=$(aws s3 cp /tmp/$1 $s3Uri --region $AWS_DEFAULT_REGION $AWS_S3_OPTIONS)
  echo "$s3Result"
}


uploadTarball(){
  #Call to mount uri S3.
  s3Uri=$(mountUriS3 $1 $AWS_S3_BUCKET_NAME $AWS_S3_PATH)

  local createS3BucketResult=$(createS3Bucket)
  echo "$createS3BucketResult"

  echo "Starting Upload Tarball from: /tmp/$1 to $s3Uri"
  local s3Result=$(uploadToS3 $1)
  echo "$s3Result"
}
