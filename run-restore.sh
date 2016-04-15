#!/bin/bash
#
# Restore From AWS S3
# Author: frekele
#

set -e

timeBegin=$(date +%Y%m%d%H%M%S)
echo ""
echo "timeBegin=$timeBegin"
echo ""

if [ "$BACKUP_NAME" ]; then
    fileName="$BACKUP_NAME-$BACKUP_VERSION.tar.gz"
else
    fileName="$BACKUP_VERSION.tar.gz"
fi
echo "fileName=$fileName"
echo ""

now=$(date +%s%3N)
retoreFileName = "$now_restore_$fileName"
echo "retoreFileName=$retoreFileName"
echo ""

#Remove slash in end the URI.
AWS_S3_PATH=`echo "${AWS_S3_PATH}" | sed 's#/*$##'`
DATA_PATH=`echo "${DATA_PATH}" | sed 's#/*$##'`


echo "Starting download backup from $AWS_S3_PATH/$fileName to /tmp/$retoreFileName"
s3Result=$(aws s3 cp $AWS_S3_PATH/$fileName /tmp/$retoreFileName)
echo ""

echo "s3Result=$s3Result"
echo ""

echo "Starting extract restore from /tmp/$retoreFileName to $DATA_PATH/"
tar -zcf /tmp/$retoreFileName  -C $DATA_PATH/
echo ""

echo "Remove file in /tmp/$retoreFileName"
rm -f /tmp/$retoreFileName

timeEnd=$(date +%Y%m%d%H%M%S)
echo "timeEnd=$timeEnd"
echo ""

timeDuration=$((timeEnd - timeBegin))
echo "timeDuration=$timeDuration second(s)"
echo ""
