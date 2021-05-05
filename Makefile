up:
	cd docker && docker-compose up -d
build:
	cd docker && docker-compose build --no-cache --force-rm
laravel-install:
	cd docker && docker-compose exec app composer create-project --prefer-dist "laravel/laravel=8.*" .
down:
	cd docker && docker-compose down --remove-orphans
destroy:
	cd docker && docker-compose down --rmi all --volumes --remove-orphans
destroy-volumes:
	cd docker && docker-compose down --volumes --remove-orphans
app:
	cd docker && docker-compose exec app ash
migrate:
	cd docker && docker-compose exec app php artisan migrate
fresh-seed:
	cd docker && docker-compose exec app php artisan migrate:fresh --seed
restart:
	@make down
	@make up
ps:
	cd docker && docker-compose ps
logs:
	cd docker && docker-compose logs
logs-watch:
	cd docker && docker-compose logs --follow
log-nginx:
	cd docker && docker-compose logs nginx
log-nginx-watch:
	cd docker && docker-compose logs --follow nginx
log-app:
	cd docker && docker-compose logs app
log-app-watch:
	cd docker && docker-compose logs --follow app
log-db:
	cd docker && docker-compose logs db
log-db-watch:
	cd docker && docker-compose logs --follow db
init:
	if [[ ! -f ./docker/.env ]]; then\
		cp ./docker/.env.example ./docker/.env;\
	fi
	@make down
	@make build
	@make up
	cd docker && docker-compose exec app composer install
	if [[ ! -f ./src/.env ]]; then\
		cd docker && docker-compose exec app cp .env.example .env;\
	fi
	cd docker && docker-compose exec app composer dump-autoload
	cd docker && docker-compose exec app php artisan storage:link
	cd docker && docker-compose exec app chmod -R 777 storage bootstrap/cache
	@make fresh-seed
create-project:
	if [[ ! -f ./docker/.env ]]; then\
		cp ./docker/.env.example ./docker/.env;\
	fi
	@make build
	@make up
	@make laravel-install
	cd docker && docker-compose exec app php artisan key:generate
	cd docker && docker-compose exec app php artisan storage:link
	cd docker && docker-compose exec app chmod -R 777 storage bootstrap/cache