

Задание из 9 пунктов:

Нужно выполнить настройку PHP Application Server

1)Рут не должен иметь доступа по ssh

2)Доступ к серверу по ssh должны иметь только 2 пользователя - alex и denys

3)Доступ к серверу по ssh должен быть только по ssh ключам

4)Доступ к серверу по ssh должен быть с ограниченного набора айпи адресов ( alex: 127.0.0.1, 127.0.02 ) и  ( denys: 127.0.0.3, 127.0.0.4 )

5)На сервере должен быть установлен nginx

6)Все запросы на домен example.com должны переводиться н php-fpm, остальные должны выдавать HTTP 404

7)Доступ к серверу на 80 порт должен быть только у айпи адресов cloudflare - https://www.cloudflare.com/ips/

8)На сервере должен быть установлен PHP 7.4 с плагином amqp

9)В конфиге /etc/php/7.4/fpm/php.ini параметры upload_max_filesize и post_max_size должны быть увеличены до 20 мегабайт

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
