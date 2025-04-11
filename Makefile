.DEFAULT_GOAL := help 

.PHONY: help
help:  ## Show this help.
	@grep -E '^\S+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'

.PHONY: local-setup
local-setup: ## Sets up the local environment (e.g. install git hooks)
	scripts/local-setup.sh
	make install

.PHONY: install
install: ## Install the app packages
	 uv sync

.PHONY: update
update: ## Updates the app packages
	 uv sync

.PHONY: add-package
add-package: ## Installs a new package in the app. ex: make install package=XXX
	uv add $(package)

.PHONY: run
run: ## Runs the app
	uv run python main.py

.PHONY: check-typing
check-typing:  ## Run a static analyzer over the code to find issues
	uv run mypy .

.PHONY: check-lint
check-lint: ## Checks the code style
	uv run ruff check

.PHONY: lint
lint: ## Lints the code format
	uv run ruff check --fix

.PHONY: check-format
check-format:  ## Check format python code
	uv run ruff format --check

.PHONY: format
format:  ## Format python code
	uv run ruff format

.PHONY: test
test: ## Run all the tests
	 PYTHONPATH=. uv run pytest -n auto tests -ra

.PHONY: watch
watch: ## Run all the tests in watch mode
	 PYTHONPATH=. uv run ptw --runner "pytest -n auto tests -ra"

.PHONY: pre-commit
pre-commit: check-format check-typing check-lint test
	
.PHONY: rename-project
rename-project: ## Rename project make rename name=new-name
	sed -i 's/python-boilerplate/$(name)/' Makefile
	sed -i 's/python-boilerplate/$(name)/' .github/workflows/trivy.yml
	sed -i 's/python-boilerplate/$(name)/' pyproject.toml
