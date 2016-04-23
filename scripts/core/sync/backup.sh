#!/bin/bash
#
# Backup Sync to Provider
# Author: frekele
#

set -e

timeBegin=$(date +%Y%m%d%H%M%S)


#TODO


timeEnd=$(date +%Y%m%d%H%M%S)
timeDuration=$((timeEnd - timeBegin))

echo "timeBegin=$timeBegin"
echo "timeEnd=$timeEnd"
echo "timeDuration=$timeDuration second(s)"
