.DEFAULT_GOAL := all

all: clean build

build:
	@echo "Building..."
	python3 scripts/run.py build

clean:
	@echo "Cleaning..."
	python3 scripts/run.py clean