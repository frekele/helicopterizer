#!/bin/bash
#
# Helper.
# Author: frekele
#


#Validation General Environment Variables.
validationGeneralEnvs(){
  : ${DATA_PATH:?"Environment variable DATA_PATH is required!"}

  case $STORAGE_PROVIDER in
    "AWS")
        echo 'Cloud Provider is Amazon Simple Storage Service (S3)'
        : ${AWS_ACCESS_KEY_ID:?"Environment variable AWS_ACCESS_KEY_ID is required!"}
        : ${AWS_SECRET_ACCESS_KEY:?"Environment variable AWS_SECRET_ACCESS_KEY is required!"}
        : ${AWS_DEFAULT_REGION:?"Environment variable AWS_DEFAULT_REGION is required!"}
        : ${AWS_S3_BUCKET_NAME:?"Environment variable AWS_S3_BUCKET_NAME is required!"}
        ;;
    "AZURE")
        echo 'Set Cloud Storage Provider = Microsoft Azure Storage'
        echo 'Microsoft Azure Storage Not Supported.'
        echo 'Sorry! Not Implemented Yet. :( - Planned for the future'
        exit 1
        ;;
    "GOOGLE")
        echo 'Set Cloud Storage Provider = Google Cloud Storage'
        echo 'Google Cloud Storage Not Supported.'
        echo 'Sorry! Not Implemented Yet. :( - Planned for the future'
        exit 1
        ;;
    "RACKSPACE")
        echo 'Set Cloud Storage Provider = Rackspace Storage'
        echo 'Rackspace Storage Not Supported.'
        echo 'Sorry! Not Implemented Yet. :( - Planned for the future'
        exit 1
        ;;
    "SOFTLAYER")
        echo 'Set Cloud Storage Provider = IBM SoftLayer Storage'
        echo 'IBM SoftLayer Storage Not Supported.'
        echo 'Sorry! Not Implemented Yet. :( - Planned for the future'
        exit 1
        ;;
    "ORACLE")
        echo 'Set Cloud Storage Provider = Oracle Cloud Storage'
        echo 'Oracle Cloud Storage Not Supported.'
        echo 'Sorry! Not Implemented Yet. :( - Planned for the future'
        exit 1
        ;;
    "OPENSTACK")
        echo 'Set Cloud Storage Provider = OpenStack Swift Storage'
        echo 'OpenStack Swift Storage Not Supported.'
        echo 'Sorry! Not Implemented Yet. :( - Planned for the future'
        exit 1
        ;;
    "MINIO")
        echo 'Set Cloud Storage Provider = Minio Storage'
        echo 'Minio Storage Not Supported.'
        echo 'Sorry! Not Implemented Yet. :( - Planned for the future'
        exit 1
        ;;
    *)
        echo "Unknown Cloud Provider!"
        exit 1
  esac
}


#Validation Specific Backup|Restore Environment Variables.
validationSpecificEnvs(){
  case $1 in
    backup)
        echo ''
        ;;
    restore)
        if [ "$2" = "--tarball" ]; then
           : ${BACKUP_VERSION:?"Environment variable BACKUP_VERSION is required!"}
        fi
        ;;
    *)
  esac
}


#Print Environment Variables for Test.
printEnvs(){
  echo "STORAGE_PROVIDER=$STORAGE_PROVIDER"
  echo "BACKUP_NAME=$BACKUP_NAME"
  echo "BACKUP_VERSION=$BACKUP_VERSION"
  echo "DATA_PATH=$DATA_PATH"
  echo "CRON_SCHEDULE=$CRON_SCHEDULE"
  echo "GZIP_COMPRESSION=$GZIP_COMPRESSION"
  echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
  echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
  echo "AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION"
  echo "AWS_S3_BUCKET_NAME=$AWS_S3_BUCKET_NAME"
  echo "AWS_S3_PATH=$AWS_S3_PATH"
}


#Remove slash in end the URI.
removeSlashUri(){
  DATA_PATH=`echo "${DATA_PATH}" | sed 's#//*#/#g' | sed 's#/*$##'`
  AWS_S3_BUCKET_NAME=`echo "${AWS_S3_BUCKET_NAME}" | sed 's#//*#/#g' | sed 's#/*$##'`
  AWS_S3_PATH=`echo "${AWS_S3_PATH}" | sed 's#//*#/#g' | sed 's#/*$##'`
}


#Remove S3 Prefix (s3://)
removeS3Prefix(){
  AWS_S3_BUCKET_NAME=`echo "${AWS_S3_BUCKET_NAME}" | sed 's/s3:\/\///'`
}

