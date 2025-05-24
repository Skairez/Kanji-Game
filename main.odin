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

	//clouds: [dynamic]Cloud

	//append(&clouds, spawn_cloud(dvnisujdvn))
	
	//Set the width to 1000, each cloud is 250 wide = 4 clouds fit
	rl.InitWindow(WINDOW_WIDTH, 1600, "KanjiDrop")
	rl.SetTargetFPS(60)

	//Load the 1200 * 1200 cloud png
	cloud_texture = rl.LoadTexture("Graphic/cloud.png")

	kanji_font = load_kanji_font()

    i := 0

	spawn_cloud(clouds, {0, 1400}, number = 1, color = rl.WHITE)

	game_is_running := true

	for !rl.WindowShouldClose() {

		
		rl.BeginDrawing()
		rl.ClearBackground(rl.Color{135, 206, 250, 255})
		
		// This is the rect of ms poppins that can be moved from left to right.
		kanji_poppins_rect := get_kanji_rect_at_mouse_x()
		draw_kanji_poppins(kanji_poppins_rect, Kanji.One)

		//press N to switch through kanjis
        if rl.IsKeyPressed(.N) do i+= 1
        if i > 9 do i = 0

		// Draw the cloud
		draw_cloud(cloud1)

		if game_is_running {

			elevate_cloud(&cloud1)

			// TODO: add logic if y_kanji < cloud then deactivate hitbox BECAUSE ....
			if rl.CheckCollisionRecs(kanji_poppins_rect, cloud1.collision_rect) {
				game_is_running = false
			}
		} else {
			rl.DrawText("You lost", rl.GetScreenWidth()/2 - 250, rl.GetScreenHeight()/2, 100, rl.BLACK)
			if rl.IsKeyPressed(.R) {
				reset_cloud(&cloud1)
				game_is_running = true
			}
		}

		rl.EndDrawing()
	}
}