package game

import rl "vendor:raylib"
import "core:fmt"

MIN_CLOUD_PADDING :: 2 * KANJI_FONT_SIZE


Cloud :: struct {
	rect: rl.Rectangle,
	collision_rect: rl.Rectangle,
	stored_kanji: Kanji,  // this is converted into a color
	enabled: bool,
	visible: bool,
}

spawn_cloud :: proc(clouds: ^[dynamic]Cloud, position: rl.Vector2, stored_kanji: int, width: f32 = 250, height: f32 = 250) {
	cloud := Cloud{
		rect = rl.Rectangle{position.x, position.y, width, height},
		collision_rect = {},
		stored_kanji = Kanji(stored_kanji),
		enabled = true,
		visible = true,
	}
	update_cloud_collision(&cloud)
	append(clouds, cloud)
}

spawn_cloud_row :: proc(clouds: ^[dynamic]Cloud, true_kanji_index: int, cloud_choices: int = 2) {
	cloud_width := f32(rl.GetScreenWidth()) / f32(cloud_choices)
	if cloud_width < (KANJI_FONT_SIZE + MIN_CLOUD_PADDING) {
		spawn_cloud_row(clouds, true_kanji_index, cloud_choices -1)
		return
	}
	index_of_true_cloud := Kanji(int(rl.GetRandomValue(0, i32(cloud_choices-1))));
	for index in 0..<cloud_choices {
		random_wrong_color_kanji := Kanji(int(rl.GetRandomValue(10, custom_kanji_codepoint_count -1)));
		CLOUD_Y_POS :f32: 1400
		position := rl.Vector2{f32(index) * cloud_width, CLOUD_Y_POS }
		if index == int(index_of_true_cloud) {
			spawn_cloud(clouds, position, true_kanji_index, width = cloud_width)
		} else {
			spawn_cloud(clouds, position, int(random_wrong_color_kanji), width = cloud_width)
		}
	}
}

reset_cloud :: proc(cloud: ^Cloud) {
	cloud.rect.y = 1400
}


draw_cloud :: proc(cloud: Cloud, kanji_poppins: KanjiPoppins) {
	if !cloud.visible do return
	// Draw the cloud
	color := get_color_from_kanji(cloud.stored_kanji)
	rl.DrawTexturePro(cloud_texture, SOURCE_RECT_CLOUD, cloud.rect, {0, 0}, 0, color)
	kanji_matches := kanji_poppins.asked_kanji == int(cloud.stored_kanji)
	// DEBUG DRAWING OF THE CORRECT CLOUD
	//if kanji_matches do rl.DrawCircleV({cloud.rect.x + cloud.rect.width / 2, cloud.rect.y}, 20, rl.MAGENTA)
	//rl.DrawText(fmt.ctprintfln("%v", int(cloud.stored_kanji)), i32(cloud.rect.x + cloud.rect.width/2), i32(cloud.rect.y), 100, rl.BLACK)
}

// offset so that the hitbox triggers at the right time
update_cloud_collision :: proc(cloud: ^Cloud) {
	cloud.collision_rect = cloud.rect
	cloud.collision_rect.y = cloud.rect.y + CLOUD_HITBOX_OFFSET
}

elevate_cloud :: proc(cloud: ^Cloud, speed:f32 = 250) {
	cloud.rect.y -= speed * rl.GetFrameTime()
	update_cloud_collision(cloud)
}
