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
6. запустил из образа контейнер.
7. Донастроил файрволл, для проходения трафика по порту 9292
8. Проверил работу контейнера на удалённом хосте в GCP.
9. Зпарегистрировался на Docker Hub.
10. Запушил созданыый мной образ на Docker Hub.
11. Запустил образ на локальной машине, выкачав его с Docker Hub.

