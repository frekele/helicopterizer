#!/bin/bash

set -e

echo "Starting helicopterizer ..."

#Validation Environment Variables.
validation_envs(){
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
        echo 'Not Implemented Yet. :( - Planned for the future'
        exit 1
        ;;
    "GOOGLE")
        echo 'Set Cloud Storage Provider = Google Cloud Storage'
        echo 'Google Cloud Storage Not Supported.'
        echo 'Not Implemented Yet. :( - Planned for the future'
        exit 1
        ;;
    "RACKSPACE")
        echo 'Set Cloud Storage Provider = Rackspace Storage'
        echo 'Rackspace Storage Not Supported.'
        echo 'Not Implemented Yet. :( - Planned for the future'
        exit 1
        ;;
    "SOFTLAYER")
        echo 'Set Cloud Storage Provider = IBM SoftLayer Storage'
        echo 'IBM SoftLayer Storage Not Supported.'
        echo 'Not Implemented Yet. :( - Planned for the future'
        exit 1
        ;;
    *)
        echo "Unknown Cloud Provider!"
        exit 1
  esac
}

#Print Environment Variables for Test.
print_envs(){
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


#Run Backup.
run_backup(){
  case $STORAGE_PROVIDER in
    "AWS")
        echo "Starting Backup to AWS S3 ..."
        exec /aws/backup.sh
        ;;
    "AZURE")
        echo "Starting Backup to AZURE ..."
        exec /azure/backup.sh
        ;;
    "GOOGLE")
        echo "Starting Backup to GOOGLE ..."
        exec /google/backup.sh
        ;;
    "RACKSPACE")
        echo "Starting Backup to RACKSPACE ..."
        exec /rackspace/backup.sh
        ;;
    "SOFTLAYER")
        echo "Starting Backup to SOFTLAYER ..."
        exec /softlayer/backup.sh
        ;;
    *)
        echo "Unknown Cloud Provider for Backup!"
        exit 1
  esac
}


#Run Restore.
run_restore(){
  case $STORAGE_PROVIDER in
    "AWS")
        echo "Starting Restore to AWS S3 ..."
        exec /aws/restore.sh
        ;;
    "AZURE")
        echo "Starting Restore to AZURE ..."
        exec /azure/restore.sh
        ;;
    "GOOGLE")
        echo "Starting Restore to GOOGLE ..."
        exec /google/restore.sh
        ;;
    "RACKSPACE")
        echo "Starting Restore to RACKSPACE ..."
        exec /rackspace/restore.sh
        ;;
    "SOFTLAYER")
        echo "Starting Restore to SOFTLAYER ..."
        exec /softlayer/restore.sh
        ;;
    *)
        echo "Unknown Cloud Provider for Restore!"
        exit 1
  esac
}


#Call Validation Environment Variables.
validation_envs

#Call Print Environment Variables.
print_envs

case $1 in

    backup)
        run_backup
        ;;
    restore)
        run_restore
        ;;
    *)
        echo "Error: Invalid Parameter"
        exit 1
esac


