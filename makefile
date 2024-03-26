.PHONY: venv install tests run_dev build run_stage clean

PYTHON = python3
VENV_DIR = .venv
API_DIR = server
REQUIREMENTS_FILE = requirements.txt
MAIN_API = main
APP_NAME = app
IMAGE_NAME = fastapi-app

init: 
	@echo "Creating virtual environment..."
	@$(PYTHON) -m venv $(VENV_DIR)
	@echo "Virtual environment created."
	@echo "Installing dependencies..."
	@. $(VENV_DIR)/bin/activate; \
	pip install -r $(REQUIREMENTS_FILE) 
	@echo "Dependencies installed."

run_dev: 
	source $(VENV_DIR)/bin/activate; \
	cd $(API_DIR); \
	uvicorn $(MAIN_API):app --reload
	

tests: run_dev
	. $(VENV_DIR)/bin/activate; \
	python -m unittest tests/

build: tests 
	docker build -t $(IMAGE_NAME):latest .

run_stage: build
	docker run -d -p 127.0.0.1:8000:8000 $(IMAGE_NAME):latest

clean:
	rm -rf $(VENV_DIR)
	rm -rf __pycache__
	rm -rf .pytest_cache
	rm -rf .mypy_cache
	rm -rf .coverage
