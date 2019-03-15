#!/bin/sh

sed -i "s/passwd: \"beef\"/passwd: \"$BEEF_PASSWORD\"/" config.yaml
sed -i "s/user:   \"beef\"/user: \"$BEEF_USER\"/" config.yaml

if [ "$BEEF_SSL" == "true" ]; then
    ./generate-certificate
    sed -i "{N;s/https:\n            enable: false/https:\n            enable: true/}" config.yaml
fi

if [ -n "$BEEF_PUBLIC_IP" ]; then
    sed -i "s/#public: \"\"/public: \"$BEEF_PUBLIC_IP\"/" config.yaml
    sed -i "s/#public_port: \"\"/public_port: \"$BEEF_PUBLIC_PORT\"/" config.yaml
fi

if [ "$BEEF_MSF_ENABLE" == "true" ]; then
    sed -i '1N;$!N;s/metasploit:\n\s\{1,\}enable:\sfalse/metasploit:\n            enable: true/g;P;D' config.yaml
    # add leading space so we dont mangle callback host too!
    sed -i "s/ host: \"127.0.0.1\"/ host: \"$MSF_RPC_HOST\"/" extensions/metasploit/config.yaml
    sed -i "s/port: 55552/port: $MSF_RPC_PORT/" extensions/metasploit/config.yaml
    sed -i "s/user: \"msf\"/user: \"$MSF_RPC_USER\"/" extensions/metasploit/config.yaml
    sed -i "s/pass: \"abc123\"/pass: \"$MSF_RPC_PASS\"/" extensions/metasploit/config.yaml
    sed -i "s/callback_host: \"127.0.0.1\"/callback_host: \"$MSF_CALLBACK_HOST\"/" extensions/metasploit/config.yaml
    sed -i "s/ssl: true/ssl: $MSF_RPC_SSL/" extensions/metasploit/config.yaml
    sed -i "s/ssl_verify: true/ssl_verify: $MSF_SSL_VERIFY/" extensions/metasploit/config.yaml
fi


if [ "$BEEF_SE_ENABLE" == "true" ]; then
    #Probably not necessary - enabled by default in config file...
    sed -i "{N;s/social_engineering:\n            enable: false/social_engineering:\n            enable: true/}" config.yaml
    sed -i "s/msf_reverse_handler_host: \"172.16.45.1\"/msf_reverse_handler_host: \"$SE_POSH_HOST\"/" extensions/social_engineering/config.yaml
    sed -i "s/msf_reverse_handler_port: \"443\"/msf_reverse_handler_port: \"$SE_POSH_PORT\"/" extensions/social_engineering/config.yaml
fi

if [ "$BEEF_PHISHINGFRENZY_ENABLE" == "true" ]; then
    sed -i '1N;$!N;s/phishing_frenzy:\n\s\{1,\}enable:\sfalse/phishing_frenzy:\n            enable: true/g;P;D' config.yaml
fi

# Slow your roll in case we need to wait on metasploit to load...
sleep $BEEF_WAITTIME

#exec /bin/sh
exec ./beef