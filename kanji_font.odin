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
}
// In Odin, you can get the length of a fixed-size array using `len()`
custom_kanji_codepoint_count: i32 = i32(len(custom_kanji_codepoints))
