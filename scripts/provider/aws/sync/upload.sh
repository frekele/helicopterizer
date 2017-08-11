#!/bin/bash
#
# Upload Sync files to AWS S3
# Author: frekele
#



#Upload Sync to AWS S3.
SyncUploadToS3(){
  local s3Result=$(aws s3 sync $DATA_PATH/ $s3Uri/ --region $AWS_DEFAULT_REGION $AWS_S3_OPTIONS)
  echo "$s3Result"
}

uploadSync(){
  #Call to mount uri S3.
  s3Uri=$(mountUriS3 "/" $AWS_S3_BUCKET_NAME $AWS_S3_PATH)

  local createS3BucketResult=$(createS3Bucket)
  echo "$createS3BucketResult"

  echo "Starting Upload Sync from: $DATA_PATH/ to $s3Uri/"
  local s3Result=$(SyncUploadToS3)
  echo "$s3Result"
}
