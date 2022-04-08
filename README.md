# Описание

Моно-репозиторий всех написанных плейбуков для работы с инфраструктурой.

Концепт, запуск ansible всегда в одинаковом окружении не зависимо от системы. В момент запуска плейбук прокидывается в подготовленный docker контейнер, тем самым достигается абсолютно идентичное окружение где бы мы его не запустили.

## Запуск ansible из контейнера

Собираем контейнер

```bash
docker build . -t ansible
```

Пробрасываем внутрь контейнера сам репозиторий с плейбуками и агента, можно как просто зайти в контейнер и оттуда уже запускать плейбуки, либо запускать все и сразу.

```bash
docker run --rm -v $SSH_AUTH_SOCK:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent -v `pwd`:/etc/ansible -v $HOME:/root ansible /bin/sh
```

```bash
docker run --rm -v $SSH_AUTH_SOCK:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent -v `pwd`:/etc/ansible -v $HOME:/root ansible ansible-playbook -i inventories/stage/hosts.yml playbooks/{playbook}.yml -l {hostname} -t {tag}
```

## Запуск окружения через env скрипт

```bash
./env.sh ansible-playbook -i inventories/hosts.yml playbooks/{playbook}.yml -D -u {user} -K -l {hostname} -t {tag}
```

## Вывод ansible-facts

```bash
./env.sh ansible all -m setup -i inventories/hosts.yml -u {user} -b -l {hostname}
```
