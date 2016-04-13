FROM debian:jessie
MAINTAINER frekele <leandro.freitas@softdevelop.com.br>

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y python && \
    apt-get install -y cron

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py

RUN pip install awscli

ADD start.sh /helicopterizer.sh
RUN chmod +x /helicopterizer.sh

ADD backup.sh /run-backup.sh
RUN chmod +x /run-backup.sh

ADD restore.sh /run-restore.sh
RUN chmod +x /run-restore.sh

ENTRYPOINT ["/helicopterizer.sh"]
CMD [""]
