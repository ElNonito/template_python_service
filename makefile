.PHONY: venv install tests run_dev build run_stage clean

SHELL := /bin/bash

PYTHON = python3
VENV_DIR = .venv
API_DIR = api
REQUIREMENTS_FILE = requirements.txt
MAIN_API = main
APP_NAME = app
IMAGE_NAME = fastapi-app
VPYTHON = $(VENV_DIR)/bin/python3

# TODO: kill dev, kill docker
init: 
	$(PYTHON) -m venv $(VENV_DIR)
	. $(VENV_DIR)/bin/activate; \
	pip install -r $(REQUIREMENTS_FILE) 

tests: init
	$(VPYTHON) -m pytest

build: tests 
	docker build -t $(IMAGE_NAME):latest .

stage: build
	docker run -d -p 127.0.0.1:8000:8000 $(IMAGE_NAME):latest

clean:
	rm -rf $(VENV_DIR)
	rm -rf __pycache__
	rm -rf .pytest_cache
	rm -rf .mypy_cache
	rm -rf .coverage

dev: tests
	$(VPYTHON) -m uvicorn $(API_DIR).$(MAIN_API):app --reload
