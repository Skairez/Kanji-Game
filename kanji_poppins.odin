package game

import rl "vendor:raylib"


KanjiPoppins :: struct {
	asked_kanji: int, // index of the kanji the player has to know
	rect: rl.Rectangle,
}

randomize_asked_color :: proc(kanji_poppins: ^KanjiPoppins) {
	random_color_index := int(rl.GetRandomValue(10, 18));
	kanji_poppins.asked_kanji = random_color_index
}

draw_kanji_poppins :: proc(kanji_poppins: KanjiPoppins) {
	//rl.DrawRectangleLinesEx(kanji_poppins.rect, 3, rl.ORANGE)
	// TODO: Draw a nice kaji poppins character texture
	SOURCE_RECT_UMBRELLA :rl.Rectangle= {0,0,f32(umbrella_texture.width), f32(umbrella_texture.height)}
	umbrella_out_rect := kanji_poppins.rect
	//umbrella_out_rect.x += KANJI_FONT_SIZE / 2
	umbrella_out_rect.y -= KANJI_FONT_SIZE * 2 + 9
	umbrella_out_rect.x -= KANJI_FONT_SIZE / 2 + 30
	umbrella_out_rect.width = SOURCE_RECT_UMBRELLA.width / 4.4
	umbrella_out_rect.height = SOURCE_RECT_UMBRELLA.height / 4.4
	rl.DrawTexturePro(umbrella_texture, SOURCE_RECT_UMBRELLA, umbrella_out_rect, {0, 0}, 0, rl.WHITE)


	letter_idx := kanji_poppins.asked_kanji
    rl.DrawTextCodepoint(kanji_font, custom_kanji_codepoints[letter_idx], {kanji_poppins.rect.x, kanji_poppins.rect.y}, KANJI_FONT_SIZE, rl.BLACK)
}

// rect_y is 200, this is where our character is fixed
get_kanji_rect_at_mouse_x :: proc(rect_y: f32 = 250) -> rl.Rectangle {
	rect_x := f32(rl.GetMouseX() - KANJI_FONT_SIZE / 2)
	return rl.Rectangle{rect_x, rect_y, KANJI_FONT_SIZE, KANJI_FONT_SIZE}
}