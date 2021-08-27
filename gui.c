// GLFW includes
#define GLFW_INCLUDE_NONE
#include <GLFW/glfw3.h>

// Std includes
#include <stdio.h>

void error_callback(int error, const char *description) {
	fprintf(stderr, "Error: %s\n", description);
}

int main() {
	// Init GLFW
	if (!glfwInit()) {
		fprintf(stderr,"Error: Could not init GLFW");
		return 1;
	}

	// For error handling
	glfwSetErrorCallback(error_callback);

	// Window context
	GLFWwindow* window = glfwCreateWindow(640, 480, "Waffle", NULL, NULL);
	if (!window) {
		glfwTerminate();
		fprintf(stderr,"Error: Could not create window");
		return 1;
	}

	// OpenGL stuff
	glfwMakeContextCurrent(window);

	// OpenGL initialization
	
	// Draw loop
	while (!glfwWindowShouldClose(window)) {
		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	// Terminate GLFW and destroy the windows
	glfwDestroyWindow(window);
	glfwTerminate();
}
