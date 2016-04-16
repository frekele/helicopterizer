FROM alpine:3.3

MAINTAINER frekele <leandro.freitas@softdevelop.com.br>

RUN echo "http://dl-6.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk update \
    && apk add \
       bash \
       curl \
       wget \
       git \
       python\
       py-pip \
       docker \
    && pip install --upgrade pip \
    && pip install awscli

COPY ./scripts/*.sh /

RUN chmod +x /*.sh

ENTRYPOINT ["/run.sh"]

CMD [""]