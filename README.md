# Python Boilerplate

- This repository is meant to use as a fast starter point.
- The Python version is the 3.10.
- The project runs inside Docker using docker-compose.
- The project has configured a [Github Action](https://github.com/pmareke/python-boilerplate/actions) which runs on every push to the `main` branch.

## Folder structure

- There is a `tests` folder with the tests files.
  - In order to add new tests please follow the [pytest](https://docs.pytest.org/en/7.1.x/getting-started.html) recommendations.
- The production code goes inside the `src` folder.
- Inside the `scripts` folder you can find the git hooks files.

## Project commands

The project uses [Makefiles](https://www.gnu.org/software/make/manual/html_node/Introduction.html) to run the most common tasks:

- `help` : Shows this help.
- `local-setup`: Sets up the local environment (e.g. install git hooks).
- `build`: Builds the app.
- `run`: Runs the app.
- `check-typing`: Runs a static analyzer over the code in order to find issues.
- `check-format`: Checks the code format.
- `check-style`: Checks the code style.
- `reformat`: Formats the code.
- `test`: Run all the tests.

_In order to create a commit you have to pass the pre-commit phase which run the check and test commands._

## Packages

### Testing
- [pytest](https://docs.pytest.org/en/7.1.x/contents.html).
- [pytest-xdist](https://github.com/pytest-dev/pytest-xdist).
- [doublex](https://github.com/davidvilla/python-doublex).
- [expects](https://expects.readthedocs.io/en/stable/).
- [doublex-expects](https://github.com/jaimegildesagredo/doublex-expects).

### Code style
- [mypy](https://mypy.readthedocs.io/en/stable/).
- [flake8](https://flake8.pycqa.org/en/latest/).
- [yapf](https://github.com/google/yapf).
- [pylint](https://github.com/pylint-dev/pylint).
