# Makefile for waffle, the game engine to make games quick and easy by using LuaJIT

CC=cc
CFLAGS=-Os -std=c99
LDFLAGS=$(shell pkg-config --cflags --libs luajit) -lm -ldl
PREFIX=/usr/local
OUT=waffle
FILES=$(wildcard *.c)

build:
	$(CC) $(CFLAGS) $(FILES) $(LDFLAGS) -o $(OUT)

install: build
	mkdir -p $(PREFIX)/bin/
	cp $(OUT) $(PREFIX)/bin/
