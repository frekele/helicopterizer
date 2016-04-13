FROM debian:jessie
MAINTAINER frekele <leandro.freitas@softdevelop.com.br>

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y git && \
    apt-get install -y curl && \
    apt-get install -y wget && \
    apt-get install -y zip && \
    apt-get install -y python && \
    apt-get install -y cron && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py

RUN pip install awscli

ADD helicopterizer.sh /helicopterizer.sh
RUN chmod +x /helicopterizer.sh

ADD run-backup.sh /run-backup.sh
RUN chmod +x /run-backup.sh

ADD run-restore.sh /run-restore.sh
RUN chmod +x /run-restore.sh

ENTRYPOINT ["/helicopterizer.sh"]
CMD [""]
