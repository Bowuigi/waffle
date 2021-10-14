# Makefile for waffle, the game engine to make games quickly and easily by using Lua

CC=cc
CFLAGS=-Os -Wall
SHARED_CFLAGS=-shared -fPIC
LDFLAGS=-lm -ldl
PREFIX=/usr/local
GAME_NAME=your_game

build:
	@echo Building the waffle libraries
	mkdir -p $(GAME_NAME)/src/
	mkdir -p $(GAME_NAME)/lib/waffle/
	mkdir -p $(GAME_NAME)/lib/LICENSES/
	touch $(GAME_NAME)/src/main.lua
	
	@echo Building lua
	cd lib/extern/lua && make clean && make a
	
	@echo Building waffle
	$(CC) waffle.c -static lib/extern/lua/liblua.a $(LDFLAGS) -o waffle
	cp waffle $(GAME_NAME)/$(GAME_NAME)
	cp lib/IMPORTANT.txt $(GAME_NAME)/lib/IMPORTANT.txt
	cp -r LICENSES lib/base/LICENSES $(GAME_NAME)/lib/
	cp lib/base/*.lua $(GAME_NAME)/lib/waffle/
	
	@echo Done
