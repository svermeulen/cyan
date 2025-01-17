
SRC = $(wildcard src/cyan/*.tl) $(wildcard src/cyan/*/*.tl)
LUA = $(SRC:src/%.tl=build/%.lua)

TL = tl
TLFLAGS = --quiet -I src
BOOTSTRAP1= bin/bootstrap --no-script
BOOTSTRAP2= bin/bootstrap --no-script
BOOTSTRAP3= bin/bootstrap --no-script

build/%.lua: src/%.tl
	$(TL) $(TLFLAGS) gen --check $< -o $@

default: build/cyan/fs build/cyan/commands $(LUA)

build/cyan/fs:
	mkdir -p $@
build/cyan/commands:
	mkdir -p $@

all: clean default

clean:
	rm -rf build tmp

bootstrap: default
	@echo "Initial build"
	$(BOOTSTRAP1) build
	@echo "Replacing code"
	rm -rf build
	mv tmp build
	@echo "Building with self compiled code"
	$(BOOTSTRAP2) build
	@echo "Replacing code"
	rm -rf build
	mv tmp build
	@echo "Final build with self compiled code"
	$(BOOTSTRAP3) build
	rm -rf build
	mv tmp build

test: default
	busted

docs: default
	cyan run scripts/docgen.tl

.PHONY: clean
