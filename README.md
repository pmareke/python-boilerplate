# Python Boilerplate

- This repository is meant to use as a fast starter point.
- The Python version is the 3.10.
- The project runs inside Docker.

## Folder structure

- There is a `tests` folder with the tests
  - In order to add new tests please follow the [pytest](https://docs.pytest.org/en/7.1.x/getting-started.html) recommendations.
- The production code goes inside the `src` folder.
- Inside the `scripts` folder you can find the git hooks files.

## Project commands

The project uses [Makefiles](https://www.gnu.org/software/make/manual/html_node/Introduction.html) to run the most common tasks:

- `help` : Shows this help.
- `local-setup`: Sets up the local environment (e.g. install git hooks)
- `build`: Builds the app
- `run`: Runs the app
- `check-typing`: Runs a static analyzer over the code in order to find issues
- `check-format`: Checks the code format
- `check-style`: Checks the code style
- `reformat`: Formats the code
- `test`: Run all the tests

_In order to create a commit you have to pass the pre-commit phase which run the check and test commands._

## Packages

### Testing
- pytest
- pytest-xdist
- doublex
- expects-doublex
- expects

### Code style
- mypy
- flake8
- yapf
- pylint
