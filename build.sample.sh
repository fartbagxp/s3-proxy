#!bin/bash

export NGINX_LISTEN_PORT=8000
export NGINX_S3_BUCKET=proxy-bucket

envsubst '${NGINX_LISTEN_PORT} ${NGINX_S3_BUCKET}' < nginx.conf.template > nginx.conf