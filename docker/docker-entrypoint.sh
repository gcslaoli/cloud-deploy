#!/bin/sh
set -e
echo "Starting docker-entrypoint.sh script with PID $$ at $(date) ..."
# 如果 /tmp/.ssh 目录存在，就将其拷贝到 /root/.ssh 目录下
if [ -d "/tmp/.ssh" ]; then
    cp -r /tmp/.ssh /root/.ssh
    chmod 700 /root/.ssh
fi
# 如果 id_rsa 存在,配置权限
if [ -f /root/.ssh/id_rsa ]; then
    chmod 600 /root/.ssh/id_rsa
fi
# 如果 id_rsa.pub 存在,配置权限
if [ -f /root/.ssh/id_rsa.pub ]; then
    chmod 644 /root/.ssh/id_rsa.pub
fi

echo "... docker-entrypoint.sh script completed with PID $$ at $(date) ..."
exec "$@"
