FROM python:3.12-slim-bullseye as build
RUN apt-get update && apt-get install build-essential libzbar-dev ffmpeg libsm6 libxext6  -y

RUN pip install poetry

COPY . /basic_sdk
WORKDIR /basic_sdk
RUN poetry build
RUN rm -rf dist/*.tar.gz

FROM python:3.12.0-alpine3.18
COPY --from=build /basic_sdk/dist/* /basic_sdk/
WORKDIR /basic_sdk
RUN pip install *
RUN rm -rf /basic_sdk

ENTRYPOINT [ "basic_sdk" ]