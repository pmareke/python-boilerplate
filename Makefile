.DEFAULT_GOAL := help 

.PHONY: help
help:  ## Show this help.
	@grep -E '^\S+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'

.PHONY: local-setup
local-setup: ## Sets up the local environment (e.g. install git hooks)
	scripts/local-setup.sh

.PHONY: build
build: ## Builds the app
	docker build --no-cache -t python-boilerplate .

.PHONY: update
update: ## Updates the app packages
	docker compose run --rm --no-deps python-boilerplate poetry update

.PHONY: install
install: ## Installs a new package in the app. ex: make install package=XXX
	docker compose run --rm --no-deps python-boilerplate poetry add $(package)
	docker build --no-cache -t python-boilerplate .

.PHONY: run
run: ## Runs the app
	docker compose run --rm --no-deps python-boilerplate

.PHONY: check-typing
check-typing:  ## Run a static analyzer over the code to find issues
	docker compose run --rm --no-deps python-boilerplate poetry run mypy .

.PHONY: check-format
check-format: ## Checks the code format
	docker compose run --rm --no-deps python-boilerplate poetry run yapf --diff --recursive **/*.py

.PHONY: check-style
check-style: ## Checks the code style
	docker compose run --rm --no-deps python-boilerplate poetry run ruff check **/*.py

.PHONY: reformat
reformat:  ## Format python code
	docker compose run --rm --no-deps python-boilerplate poetry run yapf --parallel --recursive -ir .

.PHONY: test
test: ## Run all the tests
	docker compose run --rm --no-deps python-boilerplate poetry run pytest -n auto tests -ra

.PHONY: pre-commit
pre-commit: check-format check-typing check-style test
	
.PHONY: rename-project
rename-project: ## Rename project make rename name=new-name
	sed -i 's/python-boilerplate/$(name)/' docker-compose.yaml
	sed -i 's/python-boilerplate/$(name)/' Makefile
	sed -i 's/python-boilerplate/$(name)/' .github/workflows/trivy.yml
	sed -i 's/python-boilerplate/$(name)/' pyproject.toml
