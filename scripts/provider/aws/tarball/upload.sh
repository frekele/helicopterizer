#!/bin/bash
#
# Upload Tarball to AWS S3
# Author: frekele
#

#Upload tarball to AWS S3.
uploadToS3(){
  local s3Result=$(aws s3 --region $AWS_DEFAULT_REGION cp /tmp/$1 $s3Uri )
  echo "$s3Result"
}


uploadTarball(){
  #Call to mount uri S3.
  s3Uri=$(mountUriS3 $1 $AWS_S3_BUCKET_NAME $AWS_S3_PATH)

  echo "Starting Upload Tarball from: /tmp/$1 to $s3Uri"
  local s3Result=$(uploadToS3 $1)
  echo "$s3Result"
}
