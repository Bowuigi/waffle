# Makefile for waffle, the game engine to make games quickly and easily by using Lua

CC=cc
CFLAGS=-Os -Wall
SHARED_CFLAGS=-shared -fPIC
LDFLAGS=-lm -ldl
PREFIX=/usr/local
CMAKE_DEFOPTS=-D BUILD_SHARED_LIBS=on -D GLFW_BUILD_DOCS=off -D GLFW_BUILD_EXAMPLES=off -D GLFW_BUILD_TESTS=off -D GLFW_INSTALL=off
GLFW_LOCATION=lib/glfw/build
GAME_NAME=your_game

build:
	@echo Building the waffle libraries
	mkdir -p $(GAME_NAME)/src/lib
	touch $(GAME_NAME)/src/main.lua
	@echo Building glfw
	rm -rf $(GLFW_LOCATION)
	mkdir -p $(GLFW_LOCATION)
	cd $(GLFW_LOCATION) && cmake .. $(CMAKE_DEFOPTS) && make
	cp $(GLFW_LOCATION)/src/libglfw.so $(GAME_NAME)/src/lib/libglfw.so
	@echo Building glad
	cc $(CFLAGS) $(LDFLAGS) $(SHARED_CFLAGS) lib/glad/glad.c -o $(GAME_NAME)/src/lib/libglad.so
	$(CC) $(CFLAGS) $(LDFLAGS) $(SHARED_CFLAGS) -L$(GAME_NAME)/lib -lglfw -lglad lib/gui.c -o $(GAME_NAME)/src/lib/libwaffle_gui.so
#	$(CC) $(CFLAGS) $(LDFLAGS) $(SHARED_CFLAGS) lib/std.c -o libwaffle_std.so
	@echo Building lua
	cd lib/lua && make clean && make a
	@echo Building waffle
	$(CC) waffle.c -static lib/lua/liblua.a $(LDFLAGS) -o waffle
	cp waffle $(GAME_NAME)/waffle
	@echo Done
