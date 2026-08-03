COMPOSE = docker compose -f srcs/docker-compose.yml
DATA_PATH = /home/rammisse/data

all: dirs up

dirs:
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb

up:
	@$(COMPOSE) up -d --build

down:
	@$(COMPOSE) down

start:
	@$(COMPOSE) start

stop:
	@$(COMPOSE) stop

clean: down

fclean: clean
	@echo "Wiping all Docker data and removing host volumes..."
	@sudo rm -rf $(DATA_PATH)
	@docker system prune -af --volumes

re: fclean all

.PHONY: all dirs up down start stop clean fclean re