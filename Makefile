CC = gcc
CC_FLAGS = -c -fPIC -I./include/ -Wall -Wextra -Wpedantic
LD_FLAGS = -shared -I./include/

SRC_DIR = src
HDR_DIR = include
BUILD_DIR = build
PROD_DIR = bin

HEADERS = $(wildcard $(HDR_DIR)/*.h $(wildcard $(HDR_DIR)/**/*.h))
SOURCES = $(wildcard $(SRC_DIR)/*.c) $(wildcard $(SRC_DIR)/**/*.c)
OBJECTS = $(SOURCES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

LIBNAME = libmdc.so
VERSION = .1.0.0
AUTHOR = _ngtv

LIBFULLNAME = $(LIBNAME)$(VERSION)$(AUTHOR)
LIBPATH = $(PROD_DIR)/$(LIBFULLNAME)

sym: $(LIBPATH)
	ln -s $(LIBPATH) $(PROD_DIR)/$(LIBNAME)

lib: $(OBJECTS)
	@mkdir -p $(dir $(PROD_DIR))
	$(CC) $(LD_FLAGS) -o $(PROD_DIR)/$(LIBFULLNAME) $(OBJECTS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CC_FLAGS) $< -o $@

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)/*
