#!/bin/bash

set -e

echo "Starting Helicopterizer ..."

#Import helper.
. /scripts/core/helper.sh


#Run Backup.
runBackup(){
  #Remove S3 Prefix (s3://)
  removeS3Prefix

  #Remove slash in URI.
  removeSlashUri

  #Exec core backup.
  case $2 in
    tarball | sync)
        exec /scripts/core/${2}/backup.sh
        ;;
    *)
        echo "Error: Invalid Parameter, Use (tarball or sync)."
        exit 1
  esac
}


#Run Restore.
runRestore(){
  #Remove S3 Prefix (s3://)
  removeS3Prefix

  #Remove slash in URI.
  removeSlashUri

  #Exec core restore.
  case $2 in
    tarball | sync)
        exec /scripts/core/${2}/restore.sh
        ;;
    *)
        echo "Error: Invalid Parameter, Use (tarball or sync)."
        exit 1
  esac
}


#Call Validation General Environment Variables.
validationGeneralEnvs

#Call Print Environment Variables.
printEnvs


case $1 in
    backup | restore)
         if [ "$CRON_SCHEDULE" ]; then
            #Call Validation Specific Backup Environment Variables.
            validationSpecificEnvs ${@}
            #Set CRON_SCHEDULE=null to protect recursive scheduler.
            echo -e "${CRON_SCHEDULE} CRON_SCHEDULE='' /scripts/run.sh ${@}" > /var/spool/cron/crontabs/root && crond -l 0 -f
         elif [ "$1" = "backup" ]; then
            #Run Backup.
            runBackup ${@}
         elif [ "$1" = "restore" ]; then
            #Run Restore.
            runRestore ${@}
         fi
        ;;
    *)
        echo "Params: ${@}"
        echo "Error: Invalid Parameter, Use (backup or restore)."
        exit 1
esac

