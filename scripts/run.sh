#!/bin/bash

set -e

echo "Starting helicopterizer ..."

#Validation Environment Variables.
validationEnvs(){
  case $STORAGE_PROVIDER in
    "AWS")
        echo 'Cloud Provider is Amazon Simple Storage Service (S3)'
        : ${AWS_ACCESS_KEY_ID:?"Environment variable AWS_ACCESS_KEY_ID is required!"}
        : ${AWS_SECRET_ACCESS_KEY:?"Environment variable AWS_SECRET_ACCESS_KEY is required!"}
        : ${AWS_DEFAULT_REGION:?"Environment variable AWS_DEFAULT_REGION is required!"}
        : ${AWS_S3_PATH:?"Environment variable AWS_S3_PATH is required!"}
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
    *)
        echo "Unknown Cloud Provider!"
        exit 1
  esac
}

#Print Environment Variables for Test.
printEnvs(){
  echo "STORAGE_PROVIDER=$STORAGE_PROVIDER"
  echo "BACKUP_NAME=$BACKUP_NAME"
  echo "BACKUP_VERSION=$BACKUP_VERSION"
  echo "DATA_PATH=$DATA_PATH"
  echo "GZIP_COMPRESSION=$GZIP_COMPRESSION"
  echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
  echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
  echo "AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION"
  echo "AWS_S3_BUCKET_NAME=$AWS_S3_BUCKET_NAME"
  echo "AWS_S3_PATH=$AWS_S3_PATH"
}

#Remove slash in end the URI.
removeSlashUri(){
  DATA_PATH=$(readlink -m "$DATA_PATH")
  AWS_S3_BUCKET_NAME=$(readlink -m "$AWS_S3_BUCKET_NAME")
  AWS_S3_PATH=$(readlink -m "$AWS_S3_PATH")
}

#Remove S3 Prefix (s3://)
removeS3Prefix(){
  AWS_S3_BUCKET_NAME=`echo "${AWS_S3_BUCKET_NAME}" | sed 's/s3:\/\///'`
}

#Run Backup.
runBackup(){
  case $STORAGE_PROVIDER in
    "AWS")
        echo "Starting Backup to AWS S3 ..."
        exec /scripts/aws/backup.sh
        ;;
    "AZURE")
        echo "Starting Backup to AZURE ..."
        exec /scripts/azure/backup.sh
        ;;
    "GOOGLE")
        echo "Starting Backup to GOOGLE ..."
        exec /scripts/google/backup.sh
        ;;
    "RACKSPACE")
        echo "Starting Backup to RACKSPACE ..."
        exec /scripts/rackspace/backup.sh
        ;;
    "SOFTLAYER")
        echo "Starting Backup to SOFTLAYER ..."
        exec /scripts/softlayer/backup.sh
        ;;
    *)
        echo "Unknown Cloud Provider for Backup!"
        exit 1
  esac
}


#Run Restore.
runRestore(){
  case $STORAGE_PROVIDER in
    "AWS")
        echo "Starting Restore to AWS S3 ..."
        exec /scripts/aws/restore.sh
        ;;
    "AZURE")
        echo "Starting Restore to AZURE ..."
        exec /scripts/azure/restore.sh
        ;;
    "GOOGLE")
        echo "Starting Restore to GOOGLE ..."
        exec /scripts/google/restore.sh
        ;;
    "RACKSPACE")
        echo "Starting Restore to RACKSPACE ..."
        exec /scripts/rackspace/restore.sh
        ;;
    "SOFTLAYER")
        echo "Starting Restore to SOFTLAYER ..."
        exec /scripts/softlayer/restore.sh
        ;;
    *)
        echo "Unknown Cloud Provider for Restore!"
        exit 1
  esac
}


#Call Validation Environment Variables.
validationEnvs

#Call Print Environment Variables.
printEnvs

#Remove S3 Prefix (s3://)
removeS3Prefix

#Remove slash in URI.
removeSlashUri

case $1 in

    backup)
        runBackup
        ;;
    restore)
        runRestore
        ;;
    *)
        echo "Error: Invalid Parameter"
        exit 1
esac


