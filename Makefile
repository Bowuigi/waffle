# Makefile for waffle, the game engine to make games quick and easy by using LuaJIT

CC=cc
CFLAGS=-Os -std=c99
LDFLAGS=-lm -ldl $(shell pkg-config --cflags --libs luajit)
PREFIX=/usr/local
OUT=waffle
FILES=main.c

build:
	$(CC) $(CFLAGS) $(FILES) $(LDFLAGS) -o $(OUT)

install: build
	mkdir -p $(PREFIX)/bin/
	cp $(OUT) $(PREFIX)/bin/
