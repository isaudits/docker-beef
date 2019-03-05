FROM ruby:2.5.3-alpine
WORKDIR /home/

ENV LANG="C.UTF-8"

RUN apk update && \
    apk add curl git build-base openssl readline-dev zlib zlib-dev libressl-dev yaml-dev sqlite-dev sqlite libxml2-dev libxslt-dev autoconf libc6-compat ncurses5 automake libtool bison nodejs && \
    cd /home/ && \
    git clone --depth=1 --recursive https://github.com/beefproject/beef/ /home/beef && \
    cd /home/beef && \
    bundle install --without test development && \
    rm -rf /home/beef/.git && \
    apk del git build-base automake && \
    rm -rf /var/cache/apk/*

WORKDIR /home/beef/

ENV BEEF_WAITTIME="0" \
    BEEF_USER="beefuser" \
    BEEF_PASSWORD="beefpass" \
    BEEF_PUBLIC_IP="fqdn.domain.com" \
    BEEF_PUBLIC_PORT="443" \
    BEEF_MSF_ENABLE="true" \
    MSF_RPC_HOST="0.0.0.0" \
    MSF_RPC_PORT="55553" \
    MSF_RPC_USER="msfuser" \
    MSF_RPC_PASS="msfpass" \
    MSF_RPC_SSL="true" \
    MSF_SSL_VERIFY="false" \
    MSF_CALLBACK_HOST="fqdn.domain.com" \
    BEEF_SE_ENABLE="true"  \
    SE_POSH_HOST="fqdn.domain.com" \
    SE_POSH_PORT="4343" \
    BEEF_PHISHINGFRENZY_ENABLE="true"

#NOTE - have to chmod 755 entrypoint script on source filesystem or it will not be executable inside container!
COPY entrypoint.sh /home/beef/entrypoint.sh
ENTRYPOINT ["/home/beef/entrypoint.sh"]

EXPOSE 3000

CMD ["/bin/sh"]


