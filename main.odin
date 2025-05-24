package game

import "core:fmt"
import rl "vendor:raylib"

KANJI_FONT_SIZE :: 100
CLOUD_HITBOX_OFFSET :: 75 // offset so that the hitbox triggers at the right time
WINDOW_WIDTH :: 1000

SOURCE_RECT_CLOUD :rl.Rectangle: {0, 0, 1200, 1200} // png cloud


Cloud :: struct {
	rect: rl.Rectangle,
	collision_rect: rl.Rectangle,
	number: int,
	color: rl.Color,
}


main :: proc() {
	fmt.println("Hellope!")

	cloud_one := Cloud{{0, 1400, }}
	
	//Set the width to 1000, each cloud is 250 wide = 4 clouds fit
	rl.InitWindow(WINDOW_WIDTH, 1600, "KanjiDrop")
	rl.SetTargetFPS(60)

	//Load the 1200 * 1200 cloud png
	cloud_texture := rl.LoadTexture("Graphic/cloud.png")


	// Font Logic
	kanjiFontPath: cstring = "Fonts/JiyunoTsubasa.ttf"
	kanjiFontSize: i32 = 512 // Base size for rasterizing the glyphs

	kanjiFont := rl.LoadFontEx(
		kanjiFontPath,
		kanjiFontSize,
		cast([^]rune)(raw_data(custom_kanji_codepoints)),
		custom_kanji_codepoint_count,
	)

    i := 0

	//start of cloud_pos
	cloud_pos1 := rl.Vector2{0,1400}
	game_is_running := true

	for !rl.WindowShouldClose() {
		movable_kanji_rect := get_kanji_rect_at_mouse_x()
	
		rl.BeginDrawing()
		rl.ClearBackground(rl.Color{135, 206, 250, 255})

        rl.DrawTextCodepoint(kanjiFont, custom_kanji_codepoints[i], {movable_kanji_rect.x, movable_kanji_rect.y}, KANJI_FONT_SIZE, rl.BLACK)
		rl.DrawRectangleLinesEx(movable_kanji_rect, 3, rl.ORANGE)

		//press N to switch through kanjis
        if rl.IsKeyPressed(.N) do i+= 1
        if i > 9 do i = 0

		real_cloud_rect := rl.Rectangle{0, cloud_pos.y, 250, 250}
		//smaller hitbox to check colission
		cloud_rect_hitbox := rl.Rectangle{0, cloud_pos.y + 75, 250, 250}
		// Draw the cloud
		rl.DrawTexturePro(cloud_texture, SOURCE_RECT_CLOUD, real_cloud_rect, {0, 0}, 0, rl.WHITE)

		if game_is_running {
			cloud_pos.y -= 250 * rl.GetFrameTime()

			if rl.CheckCollisionRecs(movable_kanji_rect, cloud_rect_hitbox){
				game_is_running = false
			}
		} else {
			rl.DrawText("You lost", rl.GetScreenWidth()/2 - 250, rl.GetScreenHeight()/2, 100, rl.BLACK)
			if rl.IsKeyPressed(.R){
				rl.DrawTexturePro(cloud_texture, {0, 0, 1200, 1200}, real_cloud_rect, {0, 0}, 0, rl.WHITE)
				cloud_pos = rl.Vector2{0,1400}
				game_is_running = true
			}
		}

		rl.EndDrawing()

		
	}
}


// rect_y is 200, this is where our character is fixed
get_kanji_rect_at_mouse_x :: proc(rect_y: f32 = 200) -> rl.Rectangle {
	rect_x := f32(rl.GetMouseX() - KANJI_FONT_SIZE / 2)
	return rl.Rectangle{rect_x, rect_y, KANJI_FONT_SIZE, KANJI_FONT_SIZE}
}
