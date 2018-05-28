#!bin/bash

export NGINX_SERVER_NAME=localhost
if [ -z "$NGINX_S3_BUCKET" ]; then
    # only set this envar if CircleCI hasn't already set it.
    export NGINX_S3_BUCKET=proxy-bucket
fi
export NGINX_SSL_CERT_PATH=/etc/nginx/domain.crt
export NGINX_SSL_KEY_PATH=/etc/nginx/domain.key
export NGINX_SSL_DH_PATH=/etc/nginx/dhparam.pem
export NGINX_DNS_IP_1=8.8.8.8
export NGINX_DNS_IP_2=8.8.8.4

envsubst '${NGINX_SERVER_NAME}
    ${NGINX_S3_BUCKET} 
    ${NGINX_SSL_CERT_PATH} 
    ${NGINX_SSL_KEY_PATH}
    ${NGINX_SSL_DH_PATH}
    ${NGINX_DNS_IP_1}
    ${NGINX_DNS_IP_2}' \
    < nginx.conf.template > nginx.conf
