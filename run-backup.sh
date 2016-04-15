#!/bin/bash
#
# Backup to AWS S3
# Author: frekele
#

set -e

timeBegin=$(date +%Y%m%d%H%M%S)
echo ""
echo "timeBegin=$timeBegin"
echo ""

dateTimeUtc=$(date --utc +%FT%TZ)
if [ "$BACKUP_NAME" ]; then
    fileName="$BACKUP_NAME-$dateTimeUtc.tar.gz"
else
    fileName="$dateTimeUtc.tar.gz"
fi
echo "fileName=$fileName"
echo ""

#Remove slash in end the URI.
AWS_S3_PATH=`echo "${AWS_S3_PATH}" | sed 's#/*$##'`
DATA_PATH=`echo "${DATA_PATH}" | sed 's#/*$##'`

echo "Starting compress $DATA_PATH/ to /tmp/$fileName"
tar -zcf /tmp/$fileName  -C $DATA_PATH/ .
echo ""

echo "Starting backup from /tmp/$fileName to $AWS_S3_PATH/$fileName"
s3Result=$(aws s3 cp /tmp/$fileName $AWS_S3_PATH/$fileName )
echo ""

echo "s3Result=$s3Result"
echo ""

echo "Remove file in /tmp/$fileName"
rm -f /tmp/$fileName

timeEnd=$(date +%Y%m%d%H%M%S)
echo "timeEnd=$timeEnd"
echo ""

timeDuration=$((timeEnd - timeBegin))
echo "timeDuration=$timeDuration second(s)"
echo ""
