FROM alpine

WORKDIR /dashboard

# 安装必要的软件包和依赖项
RUN apk add --no-cache \
    bash \
    openssh-server \
    wget \
    iproute2 \
    vim \
    git \
    dcron \
    unzip \
    supervisor \
    nginx \
    sqlite \
    && git config --global core.bigFileThreshold 1k \
    && git config --global core.compression 0 \
    && git config --global advice.detachedHead false \
    && git config --global pack.threads 1 \
    && git config --global pack.windowMemory 50m

# 创建 entrypoint.sh 并给予执行权限
RUN echo -e "#!/bin/bash\n\nwget -qO- https://raw.githubusercontent.com/seav1/rendernz/main/init.sh | bash" > entrypoint.sh \
    && chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
