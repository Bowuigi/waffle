# Waffle

Bowuigi's game engine using [Lua](https://lua.org) for scripting games quickly and easily, made with POSIX C99

Currently a WIP

Waffle is meant to be packaged as easy as possible, so you only need these things:

- The **waffle** binary (can have any name, including the name of the game)
- An **src** folder containing main.lua
- A **lib** folder containing the necessary waffle libraries (it can contain yours too)
- The folder **LICENSES**, which contains all of the licenses used in waffle and its dependencies along with a file pointing to the pages where you can find the source code of each one (it should also contain yours)

The file tree, for a game called *your_game* would look like this:

```
your_game/
	lib/
		IMPORTANT.txt
		libglad.so
		libglfw.so
		libwaffle_gui.so
		LICENSES/
			glfw_license
			lua_license
			rxi_classic_license
			waffle_license
		waffle/
			expect.lua
			extras.lua
			log.lua
			object.lua
			tilemap.lua
	src/
		main.lua
	your_game
```

And that is it!

While that might seem like a lot of files, most are generated by the makefile, so updating waffle (or its dependencies) is usually very simple.

This is due to its modularity and the way things work.

You don't even need the **waffle** binary, as long as you set **package.path** and **package.cpath** correctly

Dependencies
---

- Lua 5.4.3 ([get it here](https://www.lua.org/download.html))
- glad/gl C 3.3 core  ([get it here](https://glad.dav1d.de/#language=c&specification=gl&api=gl%3D3.3&api=gles1%3Dnone&api=gles2%3Dnone&api=glsc2%3Dnone&profile=core&loader=on&localfiles=on))
- glfw 3.3.4 ([get it here](https://github.com/glfw/glfw/releases/download/3.3.4/glfw-3.3.4.zip))

All of those are bundled with waffle, so just running `make` should generate a `your_game` folder that contains the above said folder structure

Documentation
---

Documentation is generated using [LDoc](https://github.com/lunarmodules/LDoc)

Said documentation is on the **docs** folder on the source tree.
