#!/bin/bash
#
# Restore Tarball From Provider
# Author: frekele
#

set -e

timeBegin=$(date +%Y%m%d%H%M%S)

echo "Starting Tarball Restore From ${STORAGE_PROVIDER^^} ..."

#Import helper.
. /scripts/core/helper.sh

#Import upload script.
. /scripts/provider/${STORAGE_PROVIDER,,}/tarball/download.sh


#Extract tarball with gzip or not.
extractTarball(){
  echo "Starting extract restore from /tmp/$1 to $DATA_PATH/"
  if [ "$GZIP_COMPRESSION" = "true" ]; then
      tar -zxvf /tmp/$1  -C $DATA_PATH/
  else
      tar -xvf /tmp/$1  -C $DATA_PATH/
  fi
}


#Call to mount file name.
fileName=$(mountFileName "$BACKUP_VERSION" $GZIP_COMPRESSION "$BACKUP_PREFIX" "$BACKUP_NAME")


#Call to mount Restore file name for copy to /tmp.
restoreTempFileName=$(mountRestoreTempFileName $fileName)


#Clean data before restore Only flag CLEAN_DATA_BEFORE_RESTORE equals true.
cleanDataBeforeRestore $CLEAN_DATA_BEFORE_RESTORE


#Call Download Provider.
downloadResult=$(downloadTarball $fileName $restoreTempFileName)


#Call Extract tarball.
extractTarball $restoreTempFileName


#Call Remove File from temp dir.
removeFileTemp "$restoreTempFileName"


timeEnd=$(date +%Y%m%d%H%M%S)
timeDuration=$((timeEnd - timeBegin))

echo "fileName=$fileName"
echo "restoreTempFileName=$restoreTempFileName"
echo "downloadResult=$downloadResult"
echo "timeBegin=$timeBegin"
echo "timeEnd=$timeEnd"
echo "timeDuration=$timeDuration second(s)"
