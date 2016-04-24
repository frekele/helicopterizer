#!/bin/bash
#
# Restore Sync From Provider
# Author: frekele
#

set -e

timeBegin=$(date +%Y%m%d%H%M%S)

echo "Starting Sync Restore From ${STORAGE_PROVIDER^^} ..."

#Import helper.
. /scripts/core/helper.sh

#Import upload script.
. /scripts/provider/${STORAGE_PROVIDER,,}/sync/download.sh


#TODO


#Call Download Provider.
downloadResult=$(downloadSync)


timeEnd=$(date +%Y%m%d%H%M%S)
timeDuration=$((timeEnd - timeBegin))

echo "downloadResult=$downloadResult"
echo "timeBegin=$timeBegin"
echo "timeEnd=$timeEnd"
echo "timeDuration=$timeDuration second(s)"

