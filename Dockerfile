FROM docker:stable
ENV PUID=10000
ENV PGID=10000
WORKDIR /etc/ansible
RUN apk add --no-cache --update-cache \
    bash py-pip openssh-client git vim build-base openssl-dev libffi-dev sshpass python3 python3-dev \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir 'cryptography<=3.3' \
    && pip install --no-cache-dir docker-compose 'ansible==2.9.15' yamllint \
    && pip3 install --no-cache-dir molecule 
COPY [".", "./"]
CMD ["/bin/bash"]
