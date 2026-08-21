package thousand

import "core:fmt";
import rl "vendor:raylib";


main :: proc() {
    rl.InitWindow(800, 450, "Thousands and One - Demo")

    for !rl.WindowShouldClose() {
	rl.BeginDrawing()
	    rl.ClearBackground(rl.RAYWHITE)
	    rl.DrawText("hello world", 100, 200, 20, rl.LIGHTGRAY)
	rl.EndDrawing()
    }
    rl.CloseWindow()

}

