.DEFAULT_GOAL := help
REGISTRY = atsip
APP_SRC = src
MONI = monitoring
COMPOSE = ./docker/docker-compose.yml
help:
  @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

login: ## Login to docker hub
	docker login -u $(REGISTRY) --password-stdin $(DOCKER_PASSWORD)

build-app: ui post comment

build-monit: prometheus alertmanager blackbox-exporter cloudprober-exporter

build-log: fluentd

fluentd:
	docker build -f logging/fluentd/Dockerfile -t $(REGISTRY)/fluentd logging/fluentd

ui: ## Создание docker-образа для контейнера ui
	docker build -f $(APP_SRC)/ui/Dockerfile -t $(REGISTRY)/ui $(APP_SRC)/ui

post: ## Создание  docker-образа для контейнера post
	docker build -f $(APP_SRC)/post-py/Dockerfile -t $(REGISTRY)/post $(APP_SRC)/post-py

comment: ## Создание docker-образа для контейнера comment
	docker build -f $(APP_SRC)/comment/Dockerfile -t $(REGISTRY)/comment $(APP_SRC)/comment
#/bin/bash $(APP_SRC)/comment/docker_build.sh

prometheus: ## Создание docker-образа для контейнера prometheus
	docker build -f $(MONI)/prometheus/Dockerfile -t $(REGISTRY)/prometheus $(MONI)/prometheus

alertmanager: ## Создание docker-образа для контейнера alertmanager
	docker build -f $(MONI)/alertmanager/Dockerfile -t $(REGISTRY)/alertmanager $(MONI)/alertmanager

blackbox-exporter: ## Создание docker-образа для контейнера blackbox-exporter
	docker build -f $(MONI)/blackbox-exporter/Dockerfile -t $(REGISTRY)/blackbox-exporter $(MONI)/blackbox-exporter

cloudprober-exporter: ## Создание docker-образа для контейнера cloudprober-exporter
	docker build -f $(MONI)/cloudprober/Dockerfile -t $(REGISTRY)/cloudprober $(MONI)/cloudprober

push-images: ## Пуш созданных docker-образов в docker-registry
	docker push $(REGISTRY)/ui
	docker push $(REGISTRY)/post
	docker push $(REGISTRY)/comment
#	docker push $(REGISTRY)/prometheus
#	docker push $(REGISTRY)/alertmanager
#	docker push $(REGISTRY)/blackbox-exporter
#	docker push $(REGISTRY)/cloudprober
	docker push $(REGISTRY)/fluentd

deploy: build-app build-log push-images ###Сборка и пуш всех образов

####################################################################################################
# Управление контейнерами с помощью docker-compose (dc)
####################################################################################################
dc-build: ## Сборка docker-образов согласно инструкциям из docker-compose.yml
	docker-compose -f $(COMPOSE) build

dc-up: ## Создание и запуск docker-контейнеров, описанных в docker-compose.yml
	docker-compose -f $(COMPOSE) up -d

dc-down: ## Остановка и УДАЛЕНИЕ docker-контейнеров, описанных в docker-compose.yml
	docker-compose -f $(COMPOSE) down

dc-stop: ## Остановка docker-контейнеров, описанных в docker-compose.yml
	docker-compose -f $(COMPOSE) stop

dc-start: ## Запуск docker-контейнеров, описанных в docker-compose.yml
	docker-compose -f $(COMPOSE) start
