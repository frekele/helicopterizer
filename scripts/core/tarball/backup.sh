#!/bin/bash
#
# Backup Tarball to Provider
# Author: frekele
#

set -e

timeBegin=$(date +%Y%m%d%H%M%S)

echo "Starting Tarball Backup to ${STORAGE_PROVIDER^^} ..."

#Import helper.
. /scripts/core/helper.sh

#Import upload script.
. /scripts/provider/${STORAGE_PROVIDER,,}/tarball/upload.sh


#Create tarball with gzip or not.
compressTarball(){
  echo "Starting compress: $DATA_PATH/ to /tmp/$1"
  if [ "$GZIP_COMPRESSION" = "true" ]; then
      tar -zcvf /tmp/$1  -C $DATA_PATH/ .
  else
      tar -cvf /tmp/$1  -C $DATA_PATH/ .
  fi
}


#Call create backup version.
BACKUP_VERSION=$(createBackupVersion)


#Call to mount file name.
fileName=$(mountFileName $BACKUP_VERSION $GZIP_COMPRESSION $BACKUP_PREFIX $BACKUP_NAME)


#Call tarball Compress.
compressTarball $fileName


#Call Upload Provider.
uploadResult=$(uploadTarball $fileName)


#Call Remove File from temp dir.
removeFileTemp $fileName


timeEnd=$(date +%Y%m%d%H%M%S)
timeDuration=$((timeEnd - timeBegin))

echo "fileName=$fileName"
echo "uploadResult=$uploadResult"
echo "timeBegin=$timeBegin"
echo "timeEnd=$timeEnd"
echo "timeDuration=$timeDuration second(s)"
