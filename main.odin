package game

import "core:fmt"
import rl "vendor:raylib"

KANJI_FONT_SIZE :: 100
CLOUD_HITBOX_OFFSET :: 75 // offset so that the hitbox triggers at the right time
WINDOW_WIDTH :: 1000
SOURCE_RECT_CLOUD :rl.Rectangle: {0, 0, 1200, 1200} // png cloud 1200 x 1200


cloud_choices := 2

// cloud_width := window_width / cloudchoices
// assert(cloud_width > kanjipopins.width + 50)
// for cloud, idx in clouds do 
// draw_cloud(x = idx * cloud_width, y = ..)
// elevate_cloud(cloud)
// ...
// slices or dynamic array
//for loops everywhere where cloud 1 was
//for cloud in clouds ...


// globals
kanji_font: rl.Font
cloud_texture: rl.Texture


main :: proc() {
	fmt.println("Hellope!")

	clouds: [dynamic]Cloud
	
	//Set the width to 1000, each cloud is 250 wide = 4 clouds fit
	rl.InitWindow(WINDOW_WIDTH, 1600, "KanjiDrop")
	rl.SetTargetFPS(60)

	//Load the 1200 * 1200 cloud png
	cloud_texture = rl.LoadTexture("Graphic/cloud.png")

	kanji_font = load_kanji_font()
    kanji_index := 0

	game_is_running := true

	timer: f32 = 3
	timer_duration: f32 = 3

	tick_speed: f32= 1

	for !rl.WindowShouldClose() {

		tick_speed = rl.IsKeyDown(.LEFT_SHIFT) ? 2 : 1


		if game_is_running do timer += rl.GetFrameTime()
		if timer > timer_duration {
			timer -= timer_duration
			spawn_cloud_row(&clouds, cloud_choices = 3)
			fmt.printfln("Clouds: %v", len(clouds))
		}


		// UPDATE -----

		kanji_poppins_rect := get_kanji_rect_at_mouse_x()

		// press N to switch through kanjis
        if rl.IsKeyPressed(.N) do kanji_index += 1
        if i32(kanji_index) > custom_kanji_codepoint_count-1 do kanji_index = 0

		if game_is_running {

			for &cloud, i in clouds {
				elevate_cloud(&cloud, 250 * tick_speed)
				// TODO: add logic if y_kanji < cloud then deactivate hitbox BECAUSE ....
				if cloud.enabled && rl.CheckCollisionRecs(kanji_poppins_rect, cloud.collision_rect) {
					game_is_running = false
					cloud.enabled = false
				}

				// delete clouds that are no longer visible
				if cloud.rect.y < -cloud.rect.height do unordered_remove(&clouds, i)
			}

		} else {
			if rl.IsKeyPressed(.R) {
				game_is_running = true
			}
		}






		// DRAW -----

		rl.BeginDrawing()
		rl.ClearBackground(rl.Color{135, 206, 250, 255})
		
		// This is the rect of ms poppins that can be moved from left to right.
		draw_kanji_poppins(kanji_poppins_rect, kanji_index)

		// Draw the clouds
		for cloud in clouds do draw_cloud(cloud)

		if !game_is_running {
			rl.DrawText("You lost", rl.GetScreenWidth()/2 - 250, rl.GetScreenHeight()/2, 100, rl.BLACK)
		}
		
		rl.EndDrawing()
	}
}