FROM python:3.11.1-slim-bullseye
RUN apt-get update && apt-get install build-essential libzbar-dev ffmpeg libsm6 libxext6  -y

COPY . /basic_sdk
WORKDIR /basic_sdk

RUN pip install poetry
RUN poetry build
RUN rm -rf dist/*.tar.gz

RUN pip install dist/*

ENTRYPOINT [ "basic_sdk" ]