YML = srcs/docker-compose.yml
WEB = ${HOME}/data/web
DB = ${HOME}/data/db

build:
	mkdir -p ${WEB}
	mkdir -p ${DB}
	docker compose -f ${YML} up --build

down:
	docker volume prune --force
	docker builder prune --force         # clear build cache
	docker image prune --force           # clear dangling images
	docker system prune --force --volumes  # cleanup unused resources
	docker compose -f ${YML} down -v --remove-orphans
	sudo rm -rf ${WEB}
	sudo rm -rf ${DB}
