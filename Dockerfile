FROM docker:1.11-dind

MAINTAINER frekele <leandro.freitas@softdevelop.com.br>

RUN apk add --no-cache \
              curl \
              wget \
              git \
              openssh-client \
              python \
              && rm -rf /var/cache/apk/*


RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && pip install awscli

COPY scripts/*.sh /

ENTRYPOINT ["/helicopterizer-entrypoint.sh"]
CMD [""]
