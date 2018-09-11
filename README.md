# Dev0psPadawan_microservices
Dev0psPadawan microservices repository

**Homework docker-1**

1. Установил Docker
2. Запустил контейнер "hello-world"
3. Изучил основные команды:
- docker ps
- docker images
- docker run
- docker exec
- docker kill
- docker rm
4. Создал свой образ из контейнера



**Homework docker-2**

1. Создал новый проект (GCP) docker.
2. Установил docker-machine (встроенный в докер инструмент для создания хостов и установки на них docker engine).
3. Создал docker-хост в GCP.
4. Подготовил репозиторий для сборки образа, создав файлы:
- Dockerfile - текстовое описание нашего образа
- mongod.conf - подготовленный конфиг для mongodb
- db_config - содержит переменную окружения соссылкой на mongodb
- start.sh - скрипт запуска приложения
5. Собрал образ reddit
6. Запустил из образа контейнер.
7. Донастроил файрволл, для проходения трафика по порту 9292
8. Проверил работу контейнера на удалённом хосте в GCP.
9. Зпарегистрировался на Docker Hub.
10. Запушил созданыый мной образ на Docker Hub.
11. Запустил образ на локальной машине, выкачав его с Docker Hub.


**Homework docker-3**

1. Установил линтер hadolint.
2. Скачал архив reddit-microservices и переименовал в src.
3. Создал Docerfil(ы) для сервисов post-py, comment, ui.
4. Собрал образы post:1.0, comment:1.0 и ui:1.0, а так же скачал последний образ mongodb.
5. Создал bridge-сеть reddit.
6. Запустил контейнеры и протестировал работу приложения.
	docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db mongo:latest  
	docker run -d --network=reddit --network-alias=post dev0pspadawan/post:1.0 
	docker run -d --network=reddit --network-alias=comment dev0pspadawan/comment:1.0 
	docker run -d --network=reddit -p 9292:9292 dev0pspadawan/ui:1.0 
7. Перезапустил контейнеры с другими сетевыми алиасами, переопределив переменнные при запуске контейнера использую опцию --env.
	docker run -d --network=reddit --network-alias=new_post_db --network-alias=new_comment_db mongo:latest  
	docker run -d --network=reddit --network-alias=new_post --env POST_DATABASE_HOST=new_post_db dev0pspadawan/post:1.0 
	docker run -d --network=reddit --network-alias=new_comment --env POST_DATABASE_HOST=new_comment_db dev0pspadawan/comment:1.0 
	docker run -d --network=reddit -p 9292:9292 --env POST_SERVICE_HOST=new_post --env COMMENT_SERVICE_HOST=new_comment dev0pspadawan/ui:1.0 
8. Пересобрал образы на основе alpine linux, добившись уменьшения объёма с нескольких сотен Мб до нескольких десятков Мб под каждй образ.
9. Создал docker volume и подключил его при запуске контейнера mongodb
.
	docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest


**Homework docker-4**
1. Протестировал работу контейнера с типом сети "none" и "host"
	Контейнер с типом сети "none":
 		-имеет только loopback интерфейс
		-запускается в отдельном namespace
		-имеет доступ только до хоста
	Контейнер с типом сети "host":
		-дублирует сетевые интерфейсы хоста
		-запускается в одном namespace с хостом
		-имеет доступ только до всех узлов, что и хост
2. Протестировал работу контейнера с типом сети "bridge"  и использованием свойств name и network-alias
	--name <name> (можно задать только 1 имя)
	--network-alias <alias-name> (можно задать множество алиасов)

3. Протестировал схему работы контейнеров с отдельными сетями для frontend и backend и добавлением к контейнеру сети командой:
	docker network connect <network> <container>
4. Командой "ifconfig | grep br -A 2" сопоставил созданные bridge сети с новыми интерфейсами на хосте.
5. Командой "docker-machine ssh docker-host sudo sudo iptables -nvL -t nat" проверил создавайемые правила в файерволе для новых сетей.
6. Командой "docker-machine ssh docker-host sudo sudo  ps ax | grep docker-proxy" проверил наличие процесса отвечающего за проброс порта (в нашем случае для публикации контейнера ui)
7. Командой "pip install docker-compose" установил docker-compose на локальную машину.
8. Скачал файл docker-compose.yml, проверил что контейнеры создаются командой "docker-compose up -d"
9. Параметризовал docker-compose.yml с помощью переменных окружений, записанных в .env.
10. Изучил механизм создания базового имени проекта. По умолчанию создаётся с именем родительской дерриктории, в которой лежит конекст контейнера.
	можно изменить:
		-директивой "container_name" в файле docker-compose.yml
		-опцией -p <project_name> из командной строки
11. Создал файл docker-compose.override.yml, позволяющий дополнить docker-compose.yml.
	-для контейнеров с ruby реализована опция дебаг режима (command: "puma --debug -w 2")
	-для всех контейнеров подключён volume в директиву /app (директива, куда копируется контекст контейнера при сборке), позволяющий изменять код каждого из приложений, не выполняя сборку образа (${SRC_PATH}/${CONTAINER_NAME}:/app).
		-котнекст перенесён на docker-host командами:
		 docker-machine scp -r ui docker-host:~/app_src/
 		 docker-machine scp -r post-py docker-host:~/app_src/
		 docker-machine scp -r comment docker-host:~/app_src/



**Homework gitlab-ci-1**
1. Создал новую ВМ gitlab-ci с помощью docker-machine:
docker-machine create --driver google \
 --google-project gitlab-ci-000000 \
 --google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
 --google-machine-type n1-standard-1 \
 --google-zone europe-west1-d \
 --google-disk-size 100 \
 --google-tags http-server,https-server \
 gitlab-ci 
2. Добавил ssh-ключ:
	yum -y install sshfs
	docker-machine mount gitlab-ci:/home /tmp/docker-mount/ \
	&& cat ~/.ssh/^Cpuser.pub >> /tmp/docker-mount/docker-user/.ssh/authorized_keys \
	&& docker-machine mount gitlab-ci:/home /tmp/docker-mount/ -u
3. Установил docker, а так же подготовил окружение с помощью ansible playbook gitlab-ci.yml
4. В файле docker-compose заменил IP адрес:
	sed -i 's/<YOUR-VM-IP>/104.199.51.36/' /srv/gitlab/docker-compose.yml
5. Задеплоил Gitlab CI:
	cd /srv/gitlab && docker-compose up -d
6. В вэб-интерфейсе создал группу homework и проект exmple
7. Добавил на своей рабочей станции новый репозиторий gitlab (он же проект exmple) и запушил ветку gitlab-ci-1
	git checkout -b gitlab-ci-1
 	git remote add gitlab http://104.199.51.36/homework/example.git
 	git push gitlab gitlab-ci-1
8. Создал pipeline .gitlab-ci.yml состоящий из 3 Stage`й и 4 Job`ов и так же запушил в репозиторий gitlab.
9. В Gitlab CI получил токен, создал контейнер с Runner'ом и зарегистрировал Runner в Gitlab CI.
10. Проверил коректность работы .gitlab-ci.yml на Runner'е.
11. Добавил исходный код reddit в репозиторий и изменил описание pipeline в .gitlab-ci.yml.

12. Создал ansible playbook deploy-runner.yml для развертывания и регистрации Gitlab CI Runner. Кол-во Runner'ов задаётся переменной "runners_count"
13. Настроил интеграцию Pipeline с тестовым Slack-чатом
