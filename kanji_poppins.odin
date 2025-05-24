package game

import rl "vendor:raylib"

draw_kanji_poppins :: proc {
	draw_kanji_poppins_int,
	draw_kanji_poppins_kanji,
}

draw_kanji_poppins_int :: proc(kanji_poppins_rect: rl.Rectangle, kanji_letter: int) {
    rl.DrawTextCodepoint(kanji_font, custom_kanji_codepoints[kanji_letter], {kanji_poppins_rect.x, kanji_poppins_rect.y}, KANJI_FONT_SIZE, rl.BLACK)
	rl.DrawRectangleLinesEx(kanji_poppins_rect, 3, rl.ORANGE)
}

draw_kanji_poppins_kanji :: proc(kanji_poppins_rect: rl.Rectangle, kanji_letter: Kanji) {
    rl.DrawTextCodepoint(kanji_font, custom_kanji_codepoints[kanji_letter], {kanji_poppins_rect.x, kanji_poppins_rect.y}, KANJI_FONT_SIZE, rl.BLACK)
	rl.DrawRectangleLinesEx(kanji_poppins_rect, 3, rl.ORANGE)
}

// rect_y is 200, this is where our character is fixed
get_kanji_rect_at_mouse_x :: proc(rect_y: f32 = 200) -> rl.Rectangle {
	rect_x := f32(rl.GetMouseX() - KANJI_FONT_SIZE / 2)
	return rl.Rectangle{rect_x, rect_y, KANJI_FONT_SIZE, KANJI_FONT_SIZE}
}