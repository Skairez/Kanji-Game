package game

import "core:fmt"
import rl "vendor:raylib"

KANJI_FONT_SIZE :: 100
CLOUD_HITBOX_OFFSET :: 75 // offset so that the hitbox triggers at the right time
WINDOW_WIDTH :: 1000
SOURCE_RECT_CLOUD :rl.Rectangle: {0, 0, 1200, 1200} // png cloud 1200 x 1200


// globals
kanji_font: rl.Font
cloud_texture: rl.Texture



main :: proc() {
	fmt.println("Hellope!")
	
	//Set the width to 1000, each cloud is 250 wide = 4 clouds fit
	rl.InitWindow(WINDOW_WIDTH, 1600, "KanjiDrop")
	rl.SetTargetFPS(60)

	//Load the 1200 * 1200 cloud png
	cloud_texture = rl.LoadTexture("Graphic/cloud.png")

	kanji_font = load_kanji_font()

    i := 0

	//start of cloud_pos
	//cloud_pos := rl.Vector2{0,1400}

	cloud1 := spawn_cloud({0, 1400}, number = 1, color = rl.WHITE)

	//loud1 := Cloud{
	//	rect = rl.Rectangle{0, 1400, 250, 250},
	//	collision_rect = rl.Rectangle{0, 1400, 250, 250},
	//	number = 1,
	//	color = rl.WHITE,
	//}

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