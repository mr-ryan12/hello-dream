DATABASE_URL = postgres://postgres:postgres@localhost:5432/gleam_local

.PHONY: run test clean db-up db-down db-reset migrate migrate-up migrate-down migrate-new squirrel

run:
	@gleam run -m main

test:
	@gleam test

clean:
	@gleam clean

# Docker Compose commands
db-up:
	@docker-compose up -d postgres
	@echo "Waiting for PostgreSQL to be ready..."
	@for i in {1..30}; do docker-compose exec -T postgres pg_isready -U postgres && break || sleep 1; done

db-down:
	@docker-compose down

db-reset:
	@docker-compose down -v
	@docker-compose up -d postgres
	@echo "Waiting for PostgreSQL to be ready..."
	@for i in {1..30}; do docker-compose exec -T postgres pg_isready -U postgres && break || sleep 1; done

# Generate type-safe SQL code with Squirrel
squirrel:
	@export DATABASE_URL="$(DATABASE_URL)" && gleam run -m squirrel

# Migration commands using cigogne
migrate:
	@export DATABASE_URL="$(DATABASE_URL)" && gleam run -m cigogne all

migrate-up:
	@export DATABASE_URL="$(DATABASE_URL)" && gleam run -m cigogne up

migrate-down:
	@export DATABASE_URL="$(DATABASE_URL)" && gleam run -m cigogne down

migrate-new:
	@gleam run -m cigogne new --name $(name)