FROM alpine

WORKDIR /dashboard

# 安装必要的软件包和依赖项
RUN apk add --no-cache \
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
    bash \
    && git config --global core.bigFileThreshold 1k \
    && git config --global core.compression 0 \
    && git config --global advice.detachedHead false \
    && git config --global pack.threads 1 \
    && git config --global pack.windowMemory 50m

# 创建entrypoint.sh并给予执行权限
RUN echo "#!/usr/bin/env bash\n\n\
bash <(wget -qO- https://raw.githubusercontent.com/seav1/rendernz/main/init.sh)" > entrypoint.sh \
    && chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
