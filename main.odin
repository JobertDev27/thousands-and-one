package thousand

import rl "vendor:raylib";
import "core:fmt"

Entity :: struct {
    position: rl.Vector2,
    health: i32,
    speed: f32,
    sprite: rl.Rectangle,
}

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 450

// spritesheet
SPRITE_SIZE :: 8

main :: proc() {
    rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Thousands and One - Demo")

    sprite_sheet: rl.Texture2D = rl.LoadTexture("assets/tilemap.png")

    player :=  Entity{
	position = rl.Vector2{(SCREEN_WIDTH/2), (SCREEN_HEIGHT/2)},
	health = 10,
	speed = 2,
	sprite = {4 * SPRITE_SIZE, 0 * SPRITE_SIZE, SPRITE_SIZE, SPRITE_SIZE}
    }

    // enemies
    rat := Entity{
	position = rl.Vector2{(SCREEN_WIDTH/2)+10, (SCREEN_HEIGHT/2)+10},
	health = 2,
	speed = 10,
	sprite = {6 * SPRITE_SIZE, 1 * SPRITE_SIZE, SPRITE_SIZE, SPRITE_SIZE}
    }

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
	rat_direction: rl.Vector2 = player.position - rat.position
	rat.position += rl.Vector2Normalize(rat_direction) * rat.speed * rl.GetFrameTime()

	// movement
	if rl.IsKeyDown(.D) {
	    player.position.x += player.speed
	}
	if rl.IsKeyDown(.A) {
	    player.position.x -= player.speed
	}
	if rl.IsKeyDown(.W) {
	    player.position.y -= player.speed
	}
	if rl.IsKeyDown(.S) {
	    player.position.y += player.speed
	}

	camera.target = player.position

	// draw
	rl.BeginDrawing()
	rl.BeginMode2D(camera)

	rl.ClearBackground(rl.Color{110, 196, 71, 255})

	rl.DrawTextureRec(sprite_sheet, player.sprite, player.position, rl.WHITE)
	rl.DrawTextureRec(sprite_sheet, rat.sprite, rat.position, rl.WHITE)

	rl.EndDrawing()
    }

    // clean-up
    rl.UnloadTexture(sprite_sheet)
    rl.EndMode2D()
    rl.CloseWindow()

}

