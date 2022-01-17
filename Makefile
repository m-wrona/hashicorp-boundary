.DEFAULT_GOAL := default
.PHONY: default

default: local-docker

local-docker: local-docker-stop local-docker-start

local-docker-restart: local-docker-down local-docker-start

local-docker-start:
	@docker-compose up -d --build

local-docker-stop:
	@docker-compose stop

local-docker-down:
	@docker-compose down