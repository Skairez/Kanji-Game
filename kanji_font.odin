package game

import rl "vendor:raylib"

load_kanji_font :: proc(kanjiFontPath: cstring = "Fonts/JiyunoTsubasa.ttf", kanjiFontSize: i32 = 512) -> rl.Font {
	kanjiFont := rl.LoadFontEx(
		kanjiFontPath,
		kanjiFontSize,
		cast([^]rune)(raw_data(custom_kanji_codepoints)),
		custom_kanji_codepoint_count,
	)
	return kanjiFont
}

Kanji :: enum int {
	One = 0,
	Two,
	Three,
	Four,
	Five,
	Six,
	Seven,
	Eight,
	Nine,
	Ten,

	Black,
	Red,
	White,
	Blue,
	Green,
	Purple,
	Yellow,
	Brown,
	Gray,
}

// returns a raylib color given a kanji index
get_color_from_kanji :: proc(kanji: Kanji) -> rl.Color {
	#partial switch kanji {
	case .Black: return rl.BLACK
	case .Red: return rl.RED
	case .White: return rl.WHITE
	case .Blue: return rl.BLUE
	case .Green: return rl.GREEN
	case .Purple: return rl.PURPLE
	case .Yellow: return rl.YELLOW 
	case .Brown: return {139, 69, 19, 255}
	case .Gray: return rl.LIGHTGRAY
	}
	return rl.WHITE
}

@(rodata)
custom_kanji_codepoints := []rune {
	0x4E00, // 一 (one)
	0x4E8C, // 二 (two)
	0x4E09, // 三 (three)
	0x56DB, // 四 (four)
	0x4E94, // 五 (five)
	0x516D, // 六 (six)
	0x4E03, // 七 (seven)
	0x516B, // 八 (eight)
	0x4E5D, // 九 (nine)
	0x5341, // 十 (ten)

	//Colors
	0x9ED2, // 黒 (Black)
	0x8D64, // 赤 (Red)
	0x767D, // 白 (White)
	0x9752, // 青 (Blue)
	0x7DD1, // 緑 (Green)
	0x7D2B, // 紫 (Purple)
	0x9EC4, // 黄 (Yellow)
	0x8336, // 茶 (Brown)
	0x7070, // 灰 (Gray)

}
// In Odin, you can get the length of a fixed-size array using `len()`
custom_kanji_codepoint_count: i32 = i32(len(custom_kanji_codepoints))
