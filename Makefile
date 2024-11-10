YML = srcs/docker-compose.yml
WEB = ${HOME}/data/web
DB = ${HOME}/data/db

build:
	mkdir -p ${WEB}
	mkdir -p ${DB}
	docker compose -f ${YML} up

down:
	docker volume prune --force
	docker compose -f ${YML} down -v --remove-orphans
	sudo rm -rf ${WEB}
	sudo rm -rf ${DB}
