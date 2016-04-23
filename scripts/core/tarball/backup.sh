#!/bin/bash
#
# Backup Tarball to Provider
# Author: frekele
#

set -e

timeBegin=$(date +%Y%m%d%H%M%S)
fileName=''
s3Uri=''

#Clean the temporary file.
cleanTemp(){
  rm -v -f /tmp/$fileName
}

#Create backup version.
createBackupVersion(){
  BACKUP_VERSION=$(date --utc +%FT%TZ)
}

#Mount file name to tarball.
mountFileName(){
  local sufix=""
  if [ "$GZIP_COMPRESSION" = "true" ]; then
      sufix=".tar.gz"
  else
      sufix=".tar"
  fi

  if [ "$BACKUP_NAME" ]; then
      fileName="$BACKUP_NAME-$BACKUP_VERSION$sufix"
  else
      fileName="$BACKUP_VERSION$sufix"
  fi
}

mountUriS3(){
  if [ "$AWS_S3_PATH" ]; then
     s3Uri="$AWS_S3_BUCKET_NAME/$AWS_S3_PATH/$fileName"
  else
     s3Uri="$AWS_S3_BUCKET_NAME/$fileName"
  fi
  s3Uri=`echo "${s3Uri}" | sed 's#//*#/#g' | sed 's#/*$##'`
  s3Uri="s3://$s3Uri"
}

#Create tarball with gzip or not.
tarballCompress(){
  if [ "$GZIP_COMPRESSION" = "true" ]; then
      tar -zcvf /tmp/$fileName  -C $DATA_PATH/ .
  else
      tar -cvf /tmp/$fileName  -C $DATA_PATH/ .
  fi
}

#Upload tarball to AWS S3.
uploadToS3(){
  s3Result=$(aws s3 --region $AWS_DEFAULT_REGION cp /tmp/$fileName $s3Uri )
}


#Call create backup version.
createBackupVersion

#Call to mount file name.
mountFileName

#Call to mount uri S3.
mountUriS3

echo "Starting compress: $DATA_PATH/ to /tmp/$fileName"
tarballCompress

echo "Starting Upload from: /tmp/$fileName to $s3Uri"
uploadToS3

echo "Remove file in Directory Tem: /tmp/$fileName"
cleanTemp


timeEnd=$(date +%Y%m%d%H%M%S)
timeDuration=$((timeEnd - timeBegin))

echo "fileName=$fileName"
echo "s3Result=$s3Result"
echo "timeBegin=$timeBegin"
echo "timeEnd=$timeEnd"
echo "timeDuration=$timeDuration second(s)"
