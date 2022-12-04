FROM ubuntu:22.04
ENV TZ=Asia/Shanghai
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /cloud-deploy
RUN sed -i "s@http://archive.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && sed -i "s@http://ports.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && apt-get update && apt-get install -y python3-pip tzdata ssh\
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip install ansible
# RUN mkdir -p /root/.ssh \
#     && echo "Host *" > /root/.ssh/config \
#     && echo "StrictHostKeyChecking no" >> /root/.ssh/config \
#     && echo "UserKnownHostsFile=/dev/null" >> /root/.ssh/config \
#     && echo "LogLevel=ERROR" >> /root/.ssh/config \
#     && echo "IdentityFile /root/.ssh/id_rsa" >> /root/.ssh/config \
#     && chmod 600 /root/.ssh/config
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]