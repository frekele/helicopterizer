#!/bin/bash
#
# Restore From AWS S3
# Author: frekele
#

set -e

timeBegin=$(date +%Y%m%d%H%M%S)
fileName=''
restoreTempFileName=''
s3Uri=''

validationEnvs(){
  : ${BACKUP_VERSION:?"Environment variable BACKUP_VERSION is required!"}
}

#Clean data before restore Only flag CLEAN_DATA_BEFORE_RESTORE equals true.
cleanDataBeforeRestore(){
  if [ "$CLEAN_DATA_BEFORE_RESTORE" = "true" ]; then
      rm -v -r -f $DATA_PATH/
  fi
}

#Clean the temporary file.
cleanTemp(){
  rm -v -f /tmp/$restoreTempFileName
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

mountRestoreTempFileName(){
  local now=$(date +%s%3N)
  restoreTempFileName="$now-restore-$fileName"
}

mountUriS3(){
  if [ "$AWS_S3_PATH" ]; then
     s3Uri="$AWS_S3_BUCKET_NAME/$AWS_S3_PATH/$fileName"
  else
     s3Uri="$AWS_S3_BUCKET_NAME/$fileName"
  fi
}

#Download tarball From AWS S3.
downloadFromS3(){
  s3Result=$(aws s3 cp $s3Uri /tmp/$restoreTempFileName)
}


#Extract tarball with gzip or not.
tarballExtract(){
  if [ "$GZIP_COMPRESSION" = "true" ]; then
      tar -zxvf /tmp/$restoreTempFileName  -C $DATA_PATH/
  else
      tar -xvf /tmp/$restoreTempFileName  -C $DATA_PATH/
  fi
}


#Call Validation Environment Variables.
validationEnvs

#Call to mount file name.
mountFileName

#Call to mount Restore file name for copy to /tmp.
mountRestoreTempFileName

#Call to mount uri S3.
mountUriS3

cleanDataBeforeRestore

echo "Starting download backup from $s3Uri to /tmp/$restoreTempFileName"
downloadFromS3

echo "Starting extract restore from /tmp/$restoreTempFileName to $DATA_PATH/"
tarballExtract

echo "Remove file in /tmp/$restoreTempFileName"
cleanTemp


timeEnd=$(date +%Y%m%d%H%M%S)
timeDuration=$((timeEnd - timeBegin))

echo "fileName=$fileName"
echo "restoreTempFileName=$restoreTempFileName"
echo "s3Result=$s3Result"
echo "timeBegin=$timeBegin"
echo "timeEnd=$timeEnd"
echo "timeDuration=$timeDuration second(s)"

