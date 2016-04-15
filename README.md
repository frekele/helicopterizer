[![](https://badge.imagelayers.io/frekele/helicopterizer:latest.svg)](https://imagelayers.io/?images=frekele/helicopterizer:latest 'Get your own badge on imagelayers.io')

[![][HelicopterizerImage]][website] 

# Helicopterizer

## Backup and Restore Docker Container

[![Circle CI](https://circleci.com/gh/frekele/helicopterizer/tree/master.svg?style=shield)](https://circleci.com/gh/frekele/helicopterizer/tree/master)
[![Build Status](https://travis-ci.org/frekele/helicopterizer.svg?branch=master)](https://travis-ci.org/frekele/helicopterizer)
[![GitHub issues](https://img.shields.io/github/issues/frekele/helicopterizer.svg)](https://github.com/frekele/helicopterizer/issues)
[![GitHub forks](https://img.shields.io/github/forks/frekele/helicopterizer.svg)](https://github.com/frekele/helicopterizer/network) 
[![GitHub stars](https://img.shields.io/github/stars/frekele/helicopterizer.svg)](https://github.com/frekele/helicopterizer/stargazers)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/frekele/helicopterizer/master/LICENSE)

Image repository in the: [Docker HUB].


### Usage:

    docker run -d [Environment Variables] frekele/helicopterizer [backup|restore] [-v]



#### Cloud Storage Provider Supported:
| Provider                                    | Variable Value  | Supported                         |
| ------------------------------------------- | --------------- | --------------------------------- |
| Amazon Simple Storage Service (S3)          | AWS             | yes                               |
| Microsoft Azure Storage                     | AZURE           | no - Planned for the future       |
| Google Cloud Storage                        | GOOGLE          | no - Planned for the future       |
| IBM SoftLayer Storage                       | SOFTLAYER       | no - Planned for the future       |
| Rackspace Storage                           | RACKSPACE       | no - Planned for the future       |



#### Environment Variables:

| Variable Name                   | Default             | Action                | Required  | Description                                                     |
| ------------------------------- | ------------------- | --------------------- | --------- | --------------------------------------------------------------- |
| -e STORAGE_PROVIDER             | null                | backup,restore        | yes       | Provider name (AWS,AZURE,GOOGLE,SOFTLAYER,RACKSPACE)            |
| -e BACKUP_NAME                  | null                | backup,restore        | no        | Backup name using: $(BACKUP_NAME)-$(BACKUP_VERSION).tar.gz      |
| -e BACKUP_VERSION               | null                | restore               | yes       | Backup version using: $(BACKUP_VERSION).tar.gz                  |
| -e DATA_PATH                    | /data/              | backup,restore        | no        | Data path : /data/(your files)                                  |
| -e GZIP_COMPRESSION             | true                | backup,restore        | no        | Boolean to indicate the compression of the file .tar to .tar.gz |



#### Environment Variables for AWS S3:

| Variable Name                   | Default             | Action                | Required  | Description                                                      |
| ------------------------------- | ------------------- | --------------------- | --------- | ---------------------------------------------------------------- |
| -e AWS_ACCESS_KEY_ID            | null                | backup,restore        | yes       | AWS access key. Eg: AKRJPMI3QYCARJCRF4VF                         |
| -e AWS_SECRET_ACCESS_KEY        | null                | backup,restore        | yes       | AWS secret key. Eg: VCsrO7aVulGuiUdXbS31jtQA4iRTVgi4scftJAJr     |
| -e AWS_DEFAULT_REGION           | us-east-1           | backup,restore        | no        | Default region bucket. Eg: (sa-east-1)                           |
| -e AWS_S3_BUCKET_NAME           | null                | backup,restore        | yes       | S3 bucket name. Eg: s3://my-bucket-name/                         |
| -e AWS_S3_PATH                  | /                   | backup,restore        | no        | Relative path for bucket S3. Eg: s3://my-bucket-name/AWS_S3_PATH |



####  AWS S3 Regions:
Name                   | Description                    |
---------------------- | -------------------------------|
us-east-1              | US East (Virginia)             |
us-west-1              | US West (N. California)        |
us-west-2              | US West (Oregon)               |
eu-west-1              | EU West (Ireland)              |
eu-central-1           | EU Central (Frankfurt)         |
ap-northeast-1         | Asia Pacific (Tokyo)           |
ap-northeast-2         | Asia Pacific (Seoul)           |
ap-southeast-1         | Asia Pacific (Singapore)       |
ap-southeast-2         | Asia Pacific (Sydney)          |
sa-east-1              | South America (Sao Paulo)      |
us-gov-west-1          | US GovCloud West (Oregon)      |



### Examples:
 TODO






[HelicopterizerImage]: https://raw.githubusercontent.com/frekele/helicopterizer/master/docs/static_files/logo.png
[MIT License]: https://github.com/frekele/helicopterizer/raw/master/LICENSE.txt
[GitHub]: https://github.com/frekele/helicopterizer
[website]: https://github.com/frekele/helicopterizer/
[Docker HUB]: https://hub.docker.com/r/frekele/helicopterizer/


