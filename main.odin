package game

import "core:fmt"
import rl "vendor:raylib"


main :: proc() {
	fmt.println("Hellope!")

	rl.InitWindow(500, 800, "KanjiPoppins")
	rl.SetTargetFPS(60)


	// init font

	kanjiFontPath: cstring = "Fonts/JiyunoTsubasa.ttf"
	kanjiFontSize: i32 = 512 // Base size for rasterizing the glyphs

	kanjiFont := rl.LoadFontEx(
		kanjiFontPath,
		kanjiFontSize,
		cast([^]rune)(raw_data(custom_kanji_codepoints)),
		custom_kanji_codepoint_count,
	)

    i := 0

	for !rl.WindowShouldClose() {

		// Draw
		//----------------------------------------------------------------------------------
        KanjiPosition := rl.GetMousePosition();
		rl.BeginDrawing()

		rl.ClearBackground({135, 206, 250, 255})

        rl.DrawTextCodepoint(kanjiFont, custom_kanji_codepoints[i], KanjiPosition, 100, rl.BLACK)
        if rl.IsKeyPressed(.N) do i+= 1
        if i > 9 do i = 0


		//rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.BLACK)

		rl.EndDrawing()
	}
}
