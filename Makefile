include $(PWD)/.env
export

REGISTRY=test


test: 
	PYTHONPATH=$(shell pwd)/project poetry run pytest --ff --cov=gdshoplib --cov-report=term:skip-covered --cov-report=html -vvv ${TEST_CASE}

profile: 
	PYTHONPATH=$(shell pwd)/project poetry run pytest --profile-svg

lock:
	poetry lock

linter:
	PYTHONPATH=$(shell pwd)/project poetry run black .
	poetry run isort --atomic .

clean:
	rm -rf dist

build: test lock clean linter

release:
	poetry publish --build

push: build release


docker: 
	docker build -t ${REGISTRY} .
	docker push ${REGISTRY}