FROM ruby:2.6-slim
#FROM ruby:2.5.3-alpine

WORKDIR /home/

ENV LC_ALL C.UTF-8
ENV STAGING_KEY=RANDOM
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

#RUN apk update && \
#    apk add curl git build-base openssl readline-dev zlib zlib-dev libressl-dev yaml-dev sqlite-dev sqlite libxml2-dev libxslt-dev autoconf libc6-compat ncurses5 automake libtool bison nodejs && \
#    cd /home/ && \
#    git clone --depth=1 --recursive https://github.com/beefproject/beef/ /home/beef && \
#    cd /home/beef && \
#    bundle install --without test development && \
#    ./generate-certificate && \
#    rm -rf /home/beef/.git && \
#    apk del git build-base automake && \
#    rm -rf /var/cache/apk/*

RUN apt-get update && \
    apt-get install -y curl git build-essential openssl libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison nodejs && \
    cd /home/ && \
    git clone --depth=1 --recursive https://github.com/beefproject/beef/ /home/beef && \
    cd /home/beef && \
    bundle install --without test development && \
    ./generate-certificate && \
    rm -rf /home/beef/.git && \
    apt-get remove -y curl git build-essential automake && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/beef/

ENV BEEF_WAITTIME="0" \
    BEEF_USER="beefuser" \
    BEEF_PASSWORD="beefpass" \
    BEEF_SSL="true" \
    #BEEF_PUBLIC_IP="fqdn.domain.com" \
    #BEEF_PUBLIC_PORT="443" \
    BEEF_MSF_ENABLE="false" \
    #MSF_RPC_HOST="0.0.0.0" \
    #MSF_RPC_PORT="55553" \
    #MSF_RPC_USER="msfuser" \
    #MSF_RPC_PASS="msfpass" \
    #MSF_RPC_SSL="true" \
    #MSF_SSL_VERIFY="false" \
    #MSF_CALLBACK_HOST="fqdn.domain.com" \
    BEEF_SE_ENABLE="false"  \
    #SE_POSH_HOST="fqdn.domain.com" \
    #SE_POSH_PORT="4343" \
    BEEF_EMAIL_ENABLE="false" \
    #BEEF_EMAIL_TO="none@none.com" \
    #BEEF_EMAIL_FROM="none@none.com" \
    #BEEF_EMAIL_HOST="smtp.none.com" \
    #BEEF_EMAIL_PORT="25" \
    BEEF_PHISHINGFRENZY_ENABLE="false"

#NOTE - have to chmod 755 entrypoint script on source filesystem or it will not be executable inside container!
COPY entrypoint.sh /home/beef/entrypoint.sh
ENTRYPOINT ["/home/beef/entrypoint.sh"]

EXPOSE 3000

CMD ["/bin/sh"]


