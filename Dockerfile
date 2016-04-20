FROM alpine:3.3

MAINTAINER frekele <leandro.freitas@softdevelop.com.br>

RUN apk update --no-cache \
    && apk add --no-cache \
       bash \
       curl \
       wget \
       git \
       python\
       py-pip \
       docker \
    && curl -sL https://get.docker.com/builds/Linux/x86_64/docker-1.10.3 > /usr/bin/docker \
    && chmod +x /usr/bin/docker \
    && pip install --upgrade pip \
    && pip install awscli

ADD ./scripts /scripts

RUN chmod -R +x /scripts

ENV STORAGE_PROVIDER='' \
    BACKUP_NAME='' \
    DATA_PATH='/data/' \
    GZIP_COMPRESSION='true' \
    CLEAN_DATA_BEFORE_RESTORE='false' \
    BACKUP_VERSION='' \
    AWS_ACCESS_KEY_ID='' \
    AWS_SECRET_ACCESS_KEY='' \
    AWS_S3_BUCKET_NAME='' \
    AWS_S3_PATH='/' \
    AWS_DEFAULT_REGION='us-east-1'

ENTRYPOINT ["/scripts/run.sh"]

CMD [""]