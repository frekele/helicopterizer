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

  ```
  docker run -d [Environment Variables] frekele/helicopterizer [backup|restore] [-v|-volumes-from]
  ```


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
| STORAGE_PROVIDER                | null                | backup,restore        | yes       | Provider name (AWS,AZURE,GOOGLE,SOFTLAYER,RACKSPACE)            |
| BACKUP_NAME                     | null                | backup,restore        | no        | Backup name using: $(BACKUP_NAME)-$(BACKUP_VERSION).tar.gz      |
| BACKUP_VERSION                  | null                | restore               | yes       | Backup version using: $(BACKUP_VERSION).tar.gz                  |
| DATA_PATH                       | /data/              | backup,restore        | no        | Data path : /data/(your files)                                  |
| GZIP_COMPRESSION                | true                | backup,restore        | no        | Boolean to indicate the compression of the file .tar to .tar.gz |



#### Environment Variables for AWS S3:

| Variable Name                   | Default             | Action                | Required  | Description                                                      |
| ------------------------------- | ------------------- | --------------------- | --------- | ---------------------------------------------------------------- |
| AWS_ACCESS_KEY_ID               | null                | backup,restore        | yes       | AWS access key. Eg: AKRJPMI3QYCARJCRF4VF                         |
| AWS_SECRET_ACCESS_KEY           | null                | backup,restore        | yes       | AWS secret key. Eg: VCsrO7aVulGuiUdXbS31jtQA4iRTVgi4scftJAJr     |
| AWS_DEFAULT_REGION              | us-east-1           | backup,restore        | no        | Default region bucket. Eg: (sa-east-1)                           |
| AWS_S3_BUCKET_NAME              | null                | backup,restore        | yes       | S3 bucket name. Eg: s3://my-bucket-name/                         |
| AWS_S3_PATH                     | /                   | backup,restore        | no        | Relative path for bucket S3. Eg: s3://my-bucket-name/AWS_S3_PATH |



####  AWS S3 Regions:
Name                   | Description Region                        |
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



### Working with Persistent Data:

There are two general approaches to handling persistent storage requirements with Docker.
See [Managing Data in Containers](https://docs.docker.com/userguide/dockervolumes/) for additional information.

  1. ###Data volume container
    *Use a data volume container*. Since data volumes are persistent until no containers use them, a container can created specifically for this purpose.
     This is the recommended approach.  

    Example with Jenkins: 
       
    ```     
    docker run -d --name jenkins-data jenkinsci/jenkins:2.0 echo "data-only container for Jenkins"
    docker run -d -p 8080:8080 -p 50000:50000 --name jenkins --volumes-from jenkins-data jenkinsci/jenkins:2.0
      ```
    
    Example with Nexus:    
    
    ```
    docker run -d --name nexus-data sonatype/nexus3 echo "data-only container for Nexus"
    docker run -d -p 8081:8081 --name nexus --volumes-from nexus-data sonatype/nexus3
    ```

  2. ###Data volume
    *Mount a host directory as the volume*.  This is not portable, as it relies on the directory existing with correct permissions on the host.
     However it can be useful in certain situations where this volume needs to be assigned to certain specific underlying storage.  

    Example with Jenkins: 
      
    ```
    mkdir /some/dir/jenkins-data
    docker run -d -p 8080:8080 -p 50000:50000 --name jenkins -v /some/dir/jenkins-data:/jenkins-data jenkinsci/jenkins:2.0
    ```
    
    Example with Nexus:    
    
    ```
    mkdir /some/dir/nexus-data && chown -R 200 /some/dir/nexus-data
    docker run -d -p 8081:8081 --name nexus -v /some/dir/nexus-data:/nexus-data sonatype/nexus3
    ```

### Usage Examples:
 TODO
 


### Building:

  Build with the usual
  
    docker build -t helicopterizer .
  
  Tests are written using [bats](https://github.com/sstephenson/bats) under the `tests` dir
  
    bats tests
 
  
  
  
  
  
  
  
  

[HelicopterizerImage]: https://raw.githubusercontent.com/frekele/helicopterizer/master/docs/static_files/logo.png
[MIT License]: https://github.com/frekele/helicopterizer/raw/master/LICENSE.txt
[GitHub]: https://github.com/frekele/helicopterizer
[website]: https://github.com/frekele/helicopterizer/
[Docker HUB]: https://hub.docker.com/r/frekele/helicopterizer/


