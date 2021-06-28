#include <stdio.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

/* Convenience stuff */
static void close_state(lua_State **L) { lua_close(*L); }
#define cleanup(x) __attribute__((cleanup(x)))
#define auto_lclose cleanup(close_state) 

int main(int argc, char **argv) {
	auto_lclose lua_State *L = luaL_newstate();
	if (!L)
		return 1;

	luaL_openlibs(L);

	if (fopen("src/main.lua","r")==NULL) {
		fprintf(stderr,"Waffle, Fatal error: No source files found\n");
		return 1;
	}
	luaL_loadfile(L, "src/main.lua");
	int ret = lua_pcall(L, 0, 0, 0);
	if (ret != 0) {
		fprintf(stderr, "%s\n", lua_tostring(L, -1));
		return 1;
	}

	lua_settop(L,0);
}
