#!/bin/bash
#
# Backup to AWS S3
# Author: frekele
#

set -e

timeBegin=$(date +%Y%m%d%H%M%S)

#Remove slash in end the URI.
remove_slash_uri(){
  if [ "$DATA_PATH" = "/" ]; then
      DATA_PATH=''
  else
      DATA_PATH=`echo "${DATA_PATH}" | sed 's#/*$##'`
  fi
  AWS_S3_PATH=`echo "${AWS_S3_PATH}" | sed 's#/*$##'`
}

#Mount file name to tarball.
mountFileName(){
  local dateTimeUtc=$(date --utc +%FT%TZ)
  local sufix = ""

  if [ "$GZIP_COMPRESSION" = "true" ]; then
      sufix=".tar.gz"
  else
      sufix=".tar"
  fi

  if [ "$BACKUP_NAME" ]; then
      fileName="$BACKUP_NAME-$dateTimeUtc$sufix"
  else
      fileName="$dateTimeUtc$sufix"
  fi
}

#Create tarball with gzip or not.
tarball_compress(){
  if [ "$GZIP_COMPRESSION" = "true" ]; then
      tar -zcvf /tmp/$fileName  -C $DATA_PATH/ .
  else
      tar -cvf /tmp/$fileName  -C $DATA_PATH/ .
  fi
}

#Upload tarball to AWS S3.
upload_to_s3(){
  s3Result=$(aws s3 cp /tmp/$fileName $AWS_S3_PATH/$fileName )
}

#Call to mount file name.
mountFileName

#Remove slash in URI.
remove_slash_uri

echo "Starting compress: $DATA_PATH/ to /tmp/$fileName"
tarball_compress

echo "Starting Upload from: /tmp/$fileName to $AWS_S3_PATH/$fileName"
upload_to_s3
echo ""


echo "Remove file in Directory Tem: /tmp/$fileName"
rm -f /tmp/$fileName

timeEnd=$(date +%Y%m%d%H%M%S)

timeDuration=$((timeEnd - timeBegin))


echo "fileName=$fileName"
echo "s3Result=$s3Result"
echo "timeBegin=$timeBegin"
echo "timeEnd=$timeEnd"
echo "timeDuration=$timeDuration second(s)"