#!/bin/bash

# Для системы ubuntu 18.04 LTS
# sudo apt install apt-transport-https ca-certificates curl software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
# sudo apt install -y docker-ce

# Для установки python3 на ubuntu 18.04 LTS
# sudo add-apt-repository universe
# sudo apt install -y python3-pip

# Собираем контейнер
# docker build . -t ansible

# пример строки запуска
# ./env.sh ansible-playbook -i inventories/stage/hosts.yml playbooks/hv.yml -D -u root -l {server}

# пример запуска ad-hoc
# ./env.sh ansible -i inventories/stage/hosts.yml {server} -m shell -a 'netstat -rn' -u {mylogin} -K -D

# ansible_facts
#./env.sh ansible all -m setup -i inventories/hosts.yml -u {user} -b -l {hostname}

# запуск линтера
# ./env.sh yamllint .

ANSIBLE="ansible"

# Билд образа если его не сущевтсует
if [[ "$(docker images -q ansible 2> /dev/null)" == "" ]]; then
    docker build . -t ${ANSIBLE}
fi

docker run --rm -ti \
    -v $SSH_AUTH_SOCK:/ssh-agent \
    -e SSH_AUTH_SOCK=/ssh-agent \
    -v `pwd`:/etc/ansible \
    -v $HOME:/root ${ANSIBLE} "$@"
