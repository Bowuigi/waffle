#include <stdio.h>
#include "lib/extern/lua/lua.h"
#include "lib/extern/lua/lualib.h"
#include "lib/extern/lua/lauxlib.h"

int main(int argc, char **argv) {
	// Create a lua state
	lua_State *L = luaL_newstate();
	if (!L)
		return 1;

	// Open the standard library
	luaL_openlibs(L);

	// Check for the src/main.lua file
	if (fopen("src/main.lua","r")==NULL) {
		fprintf(stderr,"Waffle, fatal error: No source files found\n");
		return 1;
	}


	// Change the package path to load dependencies correctly
	luaL_dostring(L, "package.path = 'src/?.lua;lib/?.lua'; package.cpath = 'src/?.so;lib/?.so;src/?.dll;lib/?.dll'");

	// Execute the file
	luaL_loadfile(L, "src/main.lua");

	int ret = lua_pcall(L, 0, 0, 0);


	// Handle runtime errors
	if (ret != 0) {
		fprintf(stderr, "%s\n", lua_tostring(L, -1));
		return 1;
	}

	lua_settop(L,0);
	lua_close(L);
}
