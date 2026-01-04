# Hello Dream API

[![Package Version](https://img.shields.io/hexpm/v/dream)](https://hex.pm/packages/dream)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/dream/)

A RESTful API built with Gleam and the Dream web framework, featuring user management with PostgreSQL database integration.

## Features

- RESTful API endpoints for user management
- PostgreSQL database with migrations
- Type-safe SQL queries using Squirrel
- Docker containerized development environment
- Automated database migrations with Cigogne

## Prerequisites

- [Gleam](https://gleam.run/getting-started/installing/) (latest version)
- [Docker](https://docs.docker.com/get-docker/) and Docker Compose
- [Make](https://www.gnu.org/software/make/) (optional, for convenience commands)

## Quick Start

### 1. Clone and Setup

```bash
git clone git@github.com:mr-ryan12/hello-dream.git
cd hello-dream
```

### 2. Start Database

```bash
# Start PostgreSQL container
make db-up

# Or manually with docker-compose
docker-compose up -d postgres
```

### 3. Run Database Migrations

```bash
# Run all migrations
make migrate

# Or manually
export DATABASE_URL="postgres://postgres:postgres@localhost:5432/gleam_local"
gleam run -m cigogne all
```

### 4. Generate Type-Safe SQL

```bash
# Generate Squirrel SQL bindings
make squirrel

# Or manually
export DATABASE_URL="postgres://postgres:postgres@localhost:5432/gleam_local"
gleam run -m squirrel
```

### 5. Start the API Server

```bash
# Start the server
make run

# Or manually
gleam run -m main
```

The API will be available at `http://localhost:3000`

## API Endpoints

### Users

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/users` | List all users |
| GET | `/users/:id` | Get user by ID |
| POST | `/users` | Create new user |

### Example Requests

**Create User:**
```bash
curl -X POST http://localhost:3000/users \
  -H "Content-Type: application/json" \
  -d '{"name": "John Doe", "email": "john@example.com"}'
```

**Get All Users:**
```bash
curl http://localhost:3000/users
```

**Get User by ID:**
```bash
curl http://localhost:3000/users/1
```

## Development

### Available Make Commands

```bash
make run          # Start the application
make test         # Run tests
make clean        # Clean build artifacts

# Database commands
make db-up        # Start PostgreSQL container
make db-down      # Stop all containers
make db-reset     # Reset database (removes all data)

# Migration commands
make migrate      # Run all pending migrations
make migrate-up   # Run next migration
make migrate-down # Rollback last migration
make migrate-new name=<migration_name>  # Create new migration

# Code generation
make squirrel     # Generate type-safe SQL code
```

### Manual Commands

If you prefer not to use Make:

```bash
# Start database
docker-compose up -d postgres

# Run migrations
export DATABASE_URL="postgres://postgres:postgres@localhost:5432/gleam_local"
gleam run -m cigogne all

# Generate SQL bindings
gleam run -m squirrel

# Start server
gleam run -m main

# Run tests
gleam test
```

### Database Configuration

The application uses PostgreSQL with the following default configuration:

- **Host:** localhost
- **Port:** 5432
- **Database:** gleam_local
- **Username:** postgres
- **Password:** postgres

You can override these settings by modifying the `DATABASE_URL` environment variable.

### Project Structure

```
src/
├── controllers/   # HTTP request handlers
├── models/        # Database models
├── sql/           # SQL query files
├── types/         # Type definitions
├── views/         # Response formatting
├── main.gleam     # Application entry point
├── router.gleam   # Route definitions
├── services.gleam # Service initialization
└── sql.gleam      # Database connection

priv/
└── migrations/    # Database migration files

test/              # Test files
```

## Dependencies

- **dream** - Web framework
- **pog** - PostgreSQL driver
- **squirrel** - Type-safe SQL query builder
- **cigogne** - Database migration tool
- **gleam_json** - JSON handling

## Testing

```bash
# Run all tests
make test

# Or manually
gleam test
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests: `make test`
5. Submit a pull request

## License

MIT

## Documentation

Further documentation can be found at <https://hexdocs.pm/dream>.