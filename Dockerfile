FROM debian:jessie
MAINTAINER frekele <leandro.freitas@softdevelop.com.br>

RUN apt-get update && \
    apt-get install -y git curl wget python cron && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py

RUN pip install awscli

ADD helicopterizer.sh /helicopterizer.sh
ADD run-backup.sh /run-backup.sh
ADD run-restore.sh /run-restore.sh

RUN chmod +x /helicopterizer.sh && \
    chmod +x /run-backup.sh && \
    chmod +x /run-restore.sh

ENTRYPOINT ["/scripts/helicopterizer.sh"]
CMD [""]
