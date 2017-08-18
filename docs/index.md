# Helicopterizer

#### Solution Open Source in Backup and Restore, for Docker Container in the Cloud Providers!

[![Helicopterizer Image][HelicopterizerImage]][website]

[![ImageLayers](https://badge.imagelayers.io/frekele/helicopterizer:master.svg)](https://imagelayers.io/?images=frekele/helicopterizer:master)

[![Gitter](https://badges.gitter.im/frekele/helicopterizer.svg)](https://gitter.im/frekele/helicopterizer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Docker Pulls](https://img.shields.io/docker/pulls/frekele/helicopterizer.svg)](https://hub.docker.com/r/frekele/helicopterizer/)
[![Docker Stars](https://img.shields.io/docker/stars/frekele/helicopterizer.svg)](https://hub.docker.com/r/frekele/helicopterizer/)
[![Release](https://img.shields.io/github/release/frekele/helicopterizer.svg)](https://github.com/frekele/helicopterizer/releases/latest)


[![Circle CI](https://circleci.com/gh/frekele/helicopterizer/tree/master.svg?style=shield)](https://circleci.com/gh/frekele/helicopterizer/tree/master)
[![Build Status](https://travis-ci.org/frekele/helicopterizer.svg?branch=master)](https://travis-ci.org/frekele/helicopterizer)
[![GitHub issues](https://img.shields.io/github/issues/frekele/helicopterizer.svg)](https://github.com/frekele/helicopterizer/issues)
[![GitHub forks](https://img.shields.io/github/forks/frekele/helicopterizer.svg)](https://github.com/frekele/helicopterizer/network)
[![GitHub stars](https://img.shields.io/github/stars/frekele/helicopterizer.svg)](https://github.com/frekele/helicopterizer/stargazers)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/frekele/helicopterizer/master/LICENSE)

## Backup and Restore for Docker Container

#### Solution Open Source in Backup and Restore, for Docker Container in the Cloud Providers!


### Usage:

```
docker run -d [Environment Variables] [-v|--volumes-from] frekele/helicopterizer [backup|restore] [--tarball|--sync]
```


### Use Stable Branch for (Production)
```
docker run -d frekele/helicopterizer:stable
```


### Master Branch for (Development)
```
docker run -d frekele/helicopterizer:latest
# or
docker run -d frekele/helicopterizer
```


### Specific Tag Version

```
docker run -d frekele/helicopterizer:v0.2.1
```


#### Cloud Storage Provider Supported:
| Provider                                    | Variable Value  | Supported                         |
| ------------------------------------------- | --------------- | --------------------------------- |
| Amazon Simple Storage Service (S3)          | AWS             | yes                               |
| Microsoft Azure Storage                     | AZURE           | no - Planned for the future       |
| Google Cloud Storage                        | GOOGLE          | no - Planned for the future       |
| Rackspace Storage                           | RACKSPACE       | no - Planned for the future       |
| IBM SoftLayer Storage                       | SOFTLAYER       | no - Planned for the future       |
| Oracle Cloud Storage                        | ORACLE          | no - Planned for the future       |
| OpenStack Swift Storage (Open source)       | OPENSTACK       | no - Planned for the future       |
| Minio Storage (Open source)                 | MINIO           | no - Planned for the future       |



#### Environment Variables:
| Variable Name                   | Default             | Action                 | Required  | Option          | Description                                                     |
| ------------------------------- | ------------------- | ---------------------- | --------- | --------------- | --------------------------------------------------------------- |
| STORAGE_PROVIDER                | null                | backup, restore        | yes       | tarball, sync   | Provider name (AWS, AZURE, GOOGLE ...)                          |
| DATA_PATH                       | /data/              | backup, restore        | no        | tarball, sync   | Data path : /data/(your files)                                  |
| DATA_PATH_EXCLUDE               | null                | backup                 | no        | tarball         | Exclude file from data path (comma-separated)                   |
| CRON_SCHEDULE                   | null                | backup, restore        | no        | tarball, sync   | Cron Job Scheduler, Eg: '*/15 * * * *' run every 15 minutes     |
| BACKUP_PREFIX                   | null                | backup, restore        | no        | tarball         | Default name schema: $(BACKUP_PREFIX)$(BACKUP_VERSION).tar.gz   |
| BACKUP_NAME                     | null                | backup, restore        | no        | tarball         | If defined the name shcema is: $(BACKUP_NAME).tar.gz            |
| GZIP_COMPRESSION                | true                | backup, restore        | no        | tarball         | Boolean to indicate the compression of the file .tar to .tar.gz |
| CLEAN_DATA_BEFORE_RESTORE       | false               | restore                | no        | tarball, sync   | Clear the data directory before the restore                     |
| BACKUP_VERSION                  | null                | restore                | yes       | tarball         | Backup version using: $(BACKUP_VERSION).tar.gz                  |



#### Environment Variables for AWS S3:
| Variable Name                   | Default             | Action                 | Required  | Option          | Description                                                      |
| ------------------------------- | ------------------- | ---------------------- | --------- | --------------- | ---------------------------------------------------------------- |
| AWS_ACCESS_KEY_ID               | null                | backup, restore        | yes       | tarball, sync   | AWS access key. Eg: AKRJPMI3QYCARJCRF4VF                         |
| AWS_SECRET_ACCESS_KEY           | null                | backup, restore        | yes       | tarball, sync   | AWS secret key. Eg: VCsrO7aVulGuiUdXbS31jtQA4iRTVgi4scftJAJr     |
| AWS_S3_BUCKET_NAME              | null                | backup, restore        | yes       | tarball, sync   | S3 bucket name. Eg: s3://my-bucket-backup/                       |
| AWS_S3_BUCKET_CREATE            | false               | backup                 | no        | tarball, sync   | Boolean to indicate if we create the bucket (if not exists)      |
| AWS_S3_PATH                     | /                   | backup, restore        | no        | tarball, sync   | Relative path for bucket S3. Eg: (AWS_S3_BUCKET_NAME)/jenkins/   |
| AWS_DEFAULT_REGION              | us-east-1           | backup, restore        | no        | tarball, sync   | Default region bucket. Eg: (sa-east-1)                           |
| AWS_S3_OPTIONS                  | null                | backup, restore        | no        | tarball, sync   | AWS S3 options parameters. See in [AWS CLI S3]                   |



####  AWS S3 Regions:
Region Name            | Description the Region                    |
---------------------- | ------------------------------------------|
us-east-1              | US East (Virginia)                        |
us-west-1              | US West (N. California)                   |
us-west-2              | US West (Oregon)                          |
eu-west-1              | EU West (Ireland)                         |
eu-central-1           | EU Central (Frankfurt)                    |
ap-northeast-1         | Asia Pacific (Tokyo)                      |
ap-northeast-2         | Asia Pacific (Seoul)                      |
ap-southeast-1         | Asia Pacific (Singapore)                  |
ap-southeast-2         | Asia Pacific (Sydney)                     |
sa-east-1              | South America (Sao Paulo)                 |
us-gov-west-1          | US GovCloud West (Oregon)                 |



### Usage Examples:

Run Backup with tarball:

```
docker run --rm \
-e STORAGE_PROVIDER=AWS \
-e AWS_ACCESS_KEY_ID=XXXXXXXXXXXXX \
-e AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \
-e AWS_S3_BUCKET_NAME=s3://my-bucket-backup/ \
-v /some/dir/jenkins-data:/data:ro \
helicopterizer backup --tarball
```


Run Backup with sync filesystem:

```
docker run --rm \
-e STORAGE_PROVIDER=AWS \
-e AWS_ACCESS_KEY_ID=XXXXXXXXXXXXX \
-e AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \
-e AWS_S3_BUCKET_NAME=s3://my-bucket-backup/ \
-v /some/dir/jenkins-data:/data:ro \
helicopterizer backup --sync
```

 *Use ':ro' to mount the volumes in read-only mode.*


Run Restore with tarball:

```
docker run --rm \
-e STORAGE_PROVIDER=AWS \
-e AWS_ACCESS_KEY_ID=XXXXXXXXXXXXX \
-e AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \
-e AWS_S3_BUCKET_NAME=s3://my-bucket-backup/ \
-e BACKUP_VERSION='2016-05-04T01:34:20Z' \
-v /some/dir/jenkins-data:/data:rw \
helicopterizer restore --tarball
```


Run Restore with sync filesystem:

```
docker run --rm \
-e STORAGE_PROVIDER=AWS \
-e AWS_ACCESS_KEY_ID=XXXXXXXXXXXXX \
-e AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \
-e AWS_S3_BUCKET_NAME=s3://my-bucket-backup/ \
-e BACKUP_VERSION='2016-05-04T01:34:20Z' \
-v /some/dir/jenkins-data:/data:rw \
helicopterizer restore  --sync
```

 *Use ':rw' to mount the volumes in read-write mode.*


Run [Backup|Restore] with environment file:

```
touch ~/helicopterizer.conf
##################################
# Set Your Environment Variables:
##################################
STORAGE_PROVIDER=AWS
BACKUP_NAME=my-backup-name
DATA_PATH=/data/
GZIP_COMPRESSION=true
CLEAN_DATA_BEFORE_RESTORE=false
BACKUP_VERSION=date-time-z
AWS_ACCESS_KEY_ID=XXXXXXXXXXXXX
AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
AWS_S3_BUCKET_NAME=s3://my-bucket-backup/
AWS_S3_PATH=/
AWS_DEFAULT_REGION=us-east-1
AWS_S3_OPTIONS=
##################################
.
docker run --rm \
--env-file ~/helicopterizer.conf \
-v /some/dir/jenkins-data:/data \
helicopterizer [backup|restore] [--tarball|--sync]
```


Run [Backup|Restore] with data volume container:

```
docker run --rm \
........
-e DATA_PATH=/var/jenkins_home/ \
--volumes-from jenkins-data \
helicopterizer [backup|restore] [--tarball|--sync]
```


Run [Backup|Restore] with Cron Job Scheduler (System Timezone is UTC):

```
docker run -d \
........
-e CRON_SCHEDULE='30 4 * * *' \
helicopterizer [backup|restore] [--tarball|--sync]

#####################################################
######### Examples Cron Job Scheduler Usage #########
############## System Timezone is UTC ###############
#####################################################
- CRON_SCHEDULE='30 4 * * *' - Runs every day at 04:30;
- CRON_SCHEDULE='*/15 * * * *' - Runs every 15 Minutes;
- CRON_SCHEDULE='0 */5 * * *' - Runs every 5 Hours;
- CRON_SCHEDULE='0 */12 * * *' - Runs every 12 Hours;
- CRON_SCHEDULE='0 */32 * * *' - Runs every 32 Hours;
- CRON_SCHEDULE='0 0 */2 * *' - Runs every 2 Days;
- CRON_SCHEDULE='0 0 */7 * *' - Runs every 7 Days;
- CRON_SCHEDULE='0 0 0 */2 *' - Runs every 2 Months;
- CRON_SCHEDULE='@monthly' - Run once a Month, the same as: '0 0 1 * *';
- CRON_SCHEDULE='@weekly' - Run once a Week, the same as: '0 0 * * 0';
- CRON_SCHEDULE='@daily' - Run once a Day, the same as: '0 0 * * *';
- CRON_SCHEDULE='@midnight' - Run once a Day, the same as: '0 0 * * *' and @daily;
- CRON_SCHEDULE='@hourly' - Run once a Hour, the same as: '0 * * * *';
```

More info to usage: [Cron Wiki].



Run [Backup|Restore] with prefix name *$(BACKUP_NAME)-$(BACKUP_VERSION).tar.gz*:

```
docker run --rm \
........
-e BACKUP_NAME=my-backup-name \
helicopterizer [backup|restore] --tarball
```


Run [Backup|Restore] without gzip compression:

```
docker run --rm \
........
-e GZIP_COMPRESSION=false \
helicopterizer [backup|restore] --tarball
```


Run [Backup|Restore] with bucket creation (if NoSuchBucket):

```
docker run --rm \
........
-e AWS_S3_BUCKET_CREATE=true \
helicopterizer [backup|restore] --tarball
```


Run With clean the date before the restore:

***[Be careful here, you will lose all your data inside DATA_PATH directory].***

```
docker run --rm \
........
-e CLEAN_DATA_BEFORE_RESTORE=true \
helicopterizer restore [--tarball|--sync]
```


Run [Backup|Restore] with other data path:

```
docker run --rm \
........
-e DATA_PATH=/var/jenkins_home/ \
-v /some/dir/jenkins-data:/var/jenkins_home \
helicopterizer [backup|restore] [--tarball|--sync]
```


Run [Backup] with other data path & exclude jenkins workspace:

```
docker run --rm \
........
-e DATA_PATH=/var/jenkins_home/ \
-e DATA_PATH_EXCLUDE=workspace \
-v /some/dir/jenkins-data:/var/jenkins_home \
helicopterizer [backup|restore] [--tarball|--sync]
```


Run [Backup|Restore] with other AWS Region:

```
docker run --rm \
........
-e AWS_DEFAULT_REGION=sa-east-1 \
helicopterizer [backup|restore] [--tarball|--sync]
```


Run [Backup|Restore] with subdirectories in AWS S3:

```
docker run --rm \
........
-e AWS_S3_PATH=/project-alpha/nexus/ \
helicopterizer [backup|restore] [--tarball|--sync]
```


Run [Backup|Restore] with Options [AWS CLI S3]:

```
docker run --rm \
........
-e AWS_S3_OPTIONS='--delete' \
helicopterizer [backup|restore] [--tarball|--sync]
```




### Working with Persistent Data:

There are two general approaches to handling persistent storage requirements with Docker.
See [Managing Data in Containers](https://docs.docker.com/userguide/dockervolumes/) for additional information.

#### Data volume container

*Use a data volume container*. Since data volumes are persistent until no containers use them, a container can created specifically for this purpose.  

*Example with Jenkins:*

```
docker run -d --name jenkins-data jenkinsci/jenkins:2.0 echo "data-only container for Jenkins"
docker run -d -p 8080:8080 -p 50000:50000 --name jenkins --volumes-from jenkins-data jenkinsci/jenkins:2.0
```


*Example with Nexus:*    

```
docker run -d --name nexus-data sonatype/nexus3 echo "data-only container for Nexus"
docker run -d -p 8081:8081 --name nexus --volumes-from nexus-data sonatype/nexus3
```

#### Data volume

*Mount a host directory as the volume*.  This is not portable, as it relies on the directory existing with correct permissions on the host.
However it can be useful in certain situations where this volume needs to be assigned to certain specific underlying storage.  

*Example with Jenkins:*

```
mkdir /some/dir/jenkins-data && chown -R 1000:1000 /some/dir/jenkins-data
docker run -d -p 8080:8080 -p 50000:50000 --name jenkins -v /some/dir/jenkins-data:/var/jenkins_home jenkinsci/jenkins

# or

docker volume create --name jenkins-data
docker run -d -p 8080:8080 -p 50000:50000 --name jenkins -v jenkins-data:/var/jenkins_home jenkinsci/jenkins
```


*Example with Nexus:*

```
mkdir /some/dir/nexus-data && chown -R 200 /some/dir/nexus-data
docker run -d -p 8081:8081 --name nexus -v /some/dir/nexus-data:/nexus-data sonatype/nexus3

# or

docker volume create --name nexus-data
docker run -d -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3
```



### Building:

  Build with the usual

    docker build -t helicopterizer .

  Tests are written using [bats](https://github.com/sstephenson/bats) under the `tests` dir

    bats tests



### License:
Helicopterizer is **licensed** under the **[MIT License]**. The terms of the license are as follows:

    The MIT License (MIT)

    Copyright (c) 2016 Leandro Kersting de Freitas

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.






[HelicopterizerImage]: https://raw.githubusercontent.com/frekele/helicopterizer/master/docs/static_files/logo.png
[MIT License]: https://raw.githubusercontent.com/frekele/helicopterizer/master/LICENSE
[GitHub]: https://github.com/frekele/helicopterizer
[website]: https://github.com/frekele/helicopterizer/
[Docker HUB]: https://hub.docker.com/r/frekele/helicopterizer/
[Cron Wiki]: https://en.wikipedia.org/wiki/Cron
[AWS CLI S3]: http://docs.aws.amazon.com/cli/latest/reference/s3/sync.html
