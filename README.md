# Waffle

Bowuigi's game engine using [LuaJIT](https://luajit.org/luajit.html) and POSIX C99 for scripting games quickly and easily

Currently a WIP

Waffle is meant to be packaged extremely easy, you only need four things:

- The waffle binary (can have any name, including the name of the game)
- An src folder containing main.lua
- The file LICENSE (to comply with the GPL)
- LuaJIT (just the libraries)

The file tree, for a game called *Game* (and assuming you have LuaJIT installed) would look like this:

```
Game/
	game (waffle but renamed)
	LICENSE
	src/
		main.lua
```

And that is it!

