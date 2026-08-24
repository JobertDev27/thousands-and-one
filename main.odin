package thousand

import rl "vendor:raylib";
import "core:fmt"

Player :: struct {
    position: rl.Vector2,
    health: i32,
    speed: i32,
    sprite: rl.Texture2D,
}

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 450

main :: proc() {
    rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Thousands and One - Demo")
    
    player_sprite: rl.Texture2D = rl.LoadTexture("assets/player.png")
    player :=  Player{rl.Vector2{(SCREEN_WIDTH/2), (SCREEN_HEIGHT/2)}, 10, 5, player_sprite,}

    camera:= rl.Camera2D{
	target = player.position,
	offset = rl.Vector2{(SCREEN_WIDTH/2), (SCREEN_HEIGHT/2)},
	rotation = 0.0,
	zoom = 4.0,
    }

    for !rl.WindowShouldClose() {
	// update
	rl.SetTargetFPS(60)
	// logic
	
	fmt.println(player.position)

	// draw
	rl.BeginDrawing()
	rl.BeginMode2D(camera)

	rl.ClearBackground(rl.Color{110, 196, 71, 255})
	
	rl.DrawTextureV(player.sprite, player.position, rl.WHITE)
	

	rl.EndDrawing()
    }

    rl.UnloadTexture(player.sprite)
    rl.EndMode2D()
    rl.CloseWindow()

}

