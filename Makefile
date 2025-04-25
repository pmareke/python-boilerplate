.DEFAULT_GOAL := help 

.PHONY: help
help:  ## Show this help.
	@grep -E '^\S+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'

pre-requirements:
	@scripts/pre-requirements.sh

.PHONY: local-setup
local-setup: pre-requirements ## Sets up the local environment (e.g. install git hooks)
	scripts/local-setup.sh
	make install

.PHONY: install
install: pre-requirements ## Install the app packages
	uv python install 3.12.8
	uv python pin 3.12.8
	uv sync

.PHONY: update
update: pre-requirements ## Updates the app packages
	uv lock --upgrade

.PHONY: add-package
add-package: pre-requirements ## Installs a new package in the app. ex: make install package=XXX
	uv add $(package)

.PHONY: run
run: pre-requirements ## Runs the app
	uv run python main.py

.PHONY: check-typing
check-typing: pre-requirements  ## Run a static analyzer over the code to find issues
	uv run mypy .

.PHONY: check-lint
check-lint: pre-requirements ## Checks the code style
	uv run ruff check

.PHONY: lint
lint: pre-requirements ## Lints the code format
	uv run ruff check --fix

.PHONY: check-format
check-format: pre-requirements  ## Check format python code
	uv run ruff format --check

.PHONY: format
format: pre-requirements  ## Format python code
	uv run ruff format

.PHONY: checks
checks: pre-requirements check-lint check-format check-typing  ## Run all checks

.PHONY: test
test: pre-requirements ## Run all the tests
	 PYTHONPATH=. uv run pytest -n auto tests -ra -x --durations=5

.PHONY: watch
watch: pre-requirements ## Run all the tests in watch mode
	 PYTHONPATH=. uv run ptw --runner "pytest -n auto tests -ra -x --durations=5"

.PHONY: pre-commit
pre-commit: pre-requirements check-format check-typing check-lint test
	
.PHONY: rename-project
rename-project: ## Rename project make rename name=new-name
	sed -i 's/python-boilerplate/$(name)/' Makefile
	sed -i 's/python-boilerplate/$(name)/' pyproject.toml
