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

