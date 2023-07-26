FROM python:3.10-alpine3.18

RUN apk  update --no-cache && apk upgrade --no-cache --available

WORKDIR /code

COPY pyproject.toml /code

RUN pip install poetry

RUN poetry install

COPY . /code

CMD ["poetry", "run", "python", "main.py"]

