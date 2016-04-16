FROM debian:jessie

MAINTAINER frekele <leandro.freitas@softdevelop.com.br>

RUN apt-get update \
    && apt-get install -y \
       curl \
       wget \
       git \
       openssh-client \
       python \
       && dpkg --configure -a \
       && rm -rf /var/lib/apt/lists/* \
       && wget https://bootstrap.pypa.io/get-pip.py \
       && python get-pip.py \
       && pip install awscli

RUN curl -fsSL https://get.docker.com/gpg | apt-key add - && curl -fsSL https://get.docker.com/ | sh

ADD /scripts/*.sh /

RUN chmod +x /*.sh

ENTRYPOINT ["/helicopterizer-entrypoint.sh"]
CMD [""]
