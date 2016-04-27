#!/bin/bash
#
# Download Sync files From AWS S3
# Author: frekele
#



#Download tarball From AWS S3.
SyncDownloadFromS3(){
  local s3Result=$(aws s3 sync $s3Uri/ $DATA_PATH/ --region $AWS_DEFAULT_REGION $AWS_S3_OPTIONS)
  echo "$s3Result"
}


downloadSync(){
  #Call to mount uri S3.
  s3Uri=$(mountUriS3 "/" $AWS_S3_BUCKET_NAME $AWS_S3_PATH)

  echo "Starting Download Tarball from $s3Uri/ to $DATA_PATH/"
  local s3Result=$(SyncDownloadFromS3)
  echo "$s3Result"
}

