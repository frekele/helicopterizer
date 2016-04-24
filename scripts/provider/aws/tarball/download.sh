#!/bin/bash
#
# Download Tarball From AWS S3
# Author: frekele
#

#Download tarball From AWS S3.
downloadFromS3(){
  local s3Result=$(aws s3 cp $s3Uri /tmp/$1 --region $AWS_DEFAULT_REGION $AWS_S3_OPTIONS)
  echo "$s3Result"
}


downloadTarball(){
  #Call to mount uri S3.
  s3Uri=$(mountUriS3 $1 $AWS_S3_BUCKET_NAME $AWS_S3_PATH)

  echo "Starting Download Tarball from $s3Uri to /tmp/$2"
  local s3Result=$(downloadFromS3 $2)
  echo "$s3Result"
}
