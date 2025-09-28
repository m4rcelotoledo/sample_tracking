# Makefile for Sample Tracking
# Modern build and deployment automation

.PHONY: help build up down logs health clean dev prod test status restart stop deploy

# Default target
help: ## Show this help message
	@echo "Sample Tracking - Available Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Build and Development
build: ## Build the Docker image
	docker-compose build

up: ## Start the application
	docker-compose up -d

down: ## Stop the application
	docker-compose down

restart: ## Restart the application
	docker-compose restart

# Development Commands
dev: ## Start development environment
	docker-compose --profile dev up --build -d app-dev
	@echo "Development environment started at http://localhost:4568"

prod: ## Start production environment
	docker-compose up --build -d
	@echo "Production environment started at http://localhost:4567"

# Monitoring and Logs
logs: ## Show application logs
	docker-compose logs -f app

logs-dev: ## Show development logs
	docker-compose logs -f app-dev

health: ## Check application health
	@echo "Checking application health..."
	@curl -f http://localhost:4567/health && echo "" || echo "Health check failed"

health-dev: ## Check development health
	@echo "Checking development health..."
	@curl -f http://localhost:4568/health && echo "" || echo "Health check failed"

status: ## Show container status
	docker-compose ps

# Testing
test: ## Run tests (placeholder)
	@echo "Tests not implemented yet"

# Cleanup
clean: ## Clean up Docker resources
	docker-compose down
	docker system prune -f
	@echo "Cleanup completed"

clean-all: ## Clean up everything including images
	docker-compose down --rmi all
	docker system prune -af
	@echo "Complete cleanup finished"

# Deployment
deploy: ## Deploy to production
	@echo "Deploying to production..."
	@make down
	@make build
	@make up
	@sleep 10
	@make health
	@echo "Deployment completed successfully!"

# Environment Setup
env-setup: ## Setup environment files
	@if [ ! -f .env ]; then \
		cp env.example .env; \
		echo "Created .env from env.example"; \
	else \
		echo ".env already exists"; \
	fi

env-prod: ## Setup production environment
	@if [ ! -f .env ]; then \
		cp env.production .env; \
		echo "Created .env from env.production"; \
	else \
		echo ".env already exists"; \
	fi

# Docker Management
shell: ## Open shell in running container
	docker-compose exec app /bin/bash

shell-dev: ## Open shell in development container
	docker-compose exec app-dev /bin/bash

# Quick Commands
quick-start: env-setup up health ## Quick start (setup env + start + health check)
	@echo "Quick start completed!"

quick-dev: env-setup dev health-dev ## Quick development start
	@echo "Quick development start completed!"

# Information
info: ## Show project information
	@echo "Sample Tracking Project Information:"
	@echo "=================================="
	@echo "Ruby Version: 3.4.6"
	@echo "Sinatra Version: 3.2.0"
	@echo "Docker Compose: $(shell docker-compose version --short)"
	@echo "Docker: $(shell docker --version | cut -d' ' -f3 | cut -d',' -f1)"
	@echo ""
	@echo "Available URLs:"
	@echo "- Production: http://localhost:4567"
	@echo "- Development: http://localhost:4568"
	@echo "- Health Check: http://localhost:4567/health"
