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
	 poetry install

.PHONY: update
update: ## Updates the app packages
	 poetry update

.PHONY: add-package
add-package: ## Installs a new package in the app. ex: make install package=XXX
	poetry add $(package)

.PHONY: run
run: ## Runs the app
	python main.py

.PHONY: check-typing
check-typing:  ## Run a static analyzer over the code to find issues
	 poetry run mypy .

.PHONY: check-format
check-format: ## Checks the code format
	 poetry run black --check src tests

.PHONY: check-style
check-style: ## Checks the code style
	 poetry run ruff check **/*.py

.PHONY: format
format:  ## Format python code
	 poetry run black src tests

.PHONY: test
test: ## Run all the tests
	 PYTHONPATH=. poetry run pytest -n auto tests -ra

.PHONY: watch
watch: ## Run all the tests in watch mode
	 PYTHONPATH=. poetry run ptw --runner "pytest -n auto tests -ra"

.PHONY: pre-commit
pre-commit: check-format check-typing check-style test
	
.PHONY: rename-project
rename-project: ## Rename project make rename name=new-name
	sed -i 's/python-boilerplate/$(name)/' Makefile
	sed -i 's/python-boilerplate/$(name)/' .github/workflows/trivy.yml
	sed -i 's/python-boilerplate/$(name)/' pyproject.toml
