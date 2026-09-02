package thousand

import rl "vendor:raylib";
import "core:math/rand"
import "core:fmt"

ARENA_SIZE :: 400
// spritesheet
SPRITE_SIZE :: 8

Entity :: struct {
    position: rl.Vector2,
    health: i32,
    speed: f32,
    sprite: rl.Rectangle,
}

sprite_sheet: rl.Texture2D
map_texture : rl.RenderTexture2D

draw_Map :: proc() {
    rl.BeginTextureMode(map_texture)
    rl.ClearBackground(rl.BLACK)
    for y in 0..<50 {
	for x in 0..<50 {
	    if y == 0 || y == 49 || x == 0 || x == 49 {
		rl.DrawTextureRec(sprite_sheet, {1 * SPRITE_SIZE, 0 * SPRITE_SIZE, SPRITE_SIZE, SPRITE_SIZE}, {f32(x) * SPRITE_SIZE, f32(y) * SPRITE_SIZE}, rl.WHITE)
	    } else { 
		seed:= rand.int_max(2)
		fmt.println(seed)
		if seed == 0 {
		    rl.DrawTextureRec(sprite_sheet, {1 * SPRITE_SIZE, 1 * SPRITE_SIZE, SPRITE_SIZE, SPRITE_SIZE}, {f32(x) * SPRITE_SIZE, f32(y) * SPRITE_SIZE}, rl.WHITE)
		} else {
		    rl.DrawTextureRec(sprite_sheet, {4 * SPRITE_SIZE, 4 * SPRITE_SIZE, SPRITE_SIZE, SPRITE_SIZE}, {f32(x) * SPRITE_SIZE, f32(y) * SPRITE_SIZE}, rl.WHITE)
		}
	    }
	}
    }
    rl.EndTextureMode()
}

main :: proc() {
    rl.InitWindow(1920, 1080, "Thousands and One - Demo")

    map_texture = rl.LoadRenderTexture(ARENA_SIZE, ARENA_SIZE)

    sprite_sheet = rl.LoadTexture("assets/tilemap.png")

    player :=  Entity{
	position = rl.Vector2{(ARENA_SIZE/2), (ARENA_SIZE/2)},
	health = 10,
	speed = 2,
	sprite = {4 * SPRITE_SIZE, 0 * SPRITE_SIZE, SPRITE_SIZE, SPRITE_SIZE}
    }

    // enemies
    rat := Entity{
	position = rl.Vector2{(ARENA_SIZE/2)+10, (ARENA_SIZE/2)+10},
	health = 2,
	speed = 10,
	sprite = {6 * SPRITE_SIZE, 1 * SPRITE_SIZE, SPRITE_SIZE, SPRITE_SIZE}
    }

    camera:= rl.Camera2D{
	target = player.position,
	offset = rl.Vector2{(1920/2), (1080/2)},
	rotation = 0.0,
	zoom = 4.0,
    }

    // build map_texture
    draw_Map()

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

	rl.ClearBackground(rl.BLACK)
	rl.DrawTextureRec(
	    map_texture.texture,
	    {0, 0, ARENA_SIZE, -ARENA_SIZE},
	    {0, 0},
	    rl.WHITE,
	)

	rl.DrawTextureRec(sprite_sheet, player.sprite, player.position, rl.WHITE)
	rl.DrawTextureRec(sprite_sheet, rat.sprite, rat.position, rl.WHITE)

	rl.EndDrawing()
    }

    // clean-up
    rl.UnloadTexture(sprite_sheet)
    rl.EndMode2D()
    rl.CloseWindow()

}

