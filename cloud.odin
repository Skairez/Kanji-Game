package game

import rl "vendor:raylib"

MIN_CLOUD_PADDING :: 2 * KANJI_FONT_SIZE


Cloud :: struct {
	rect: rl.Rectangle,
	collision_rect: rl.Rectangle,
	number: int,
	color: rl.Color,
	enabled: bool,
}


spawn_cloud :: proc(clouds: ^[dynamic]Cloud, position: rl.Vector2, width: f32 = 250, height: f32 = 250, color := rl.WHITE, number := 0) {
	cloud := Cloud{
		rect = rl.Rectangle{position.x, position.y, width, height},
		collision_rect = {},
		number = number,
		color = color,
		enabled = true,
	}
	update_cloud_collision(&cloud)
	append(clouds, cloud)
}

spawn_cloud_row :: proc(clouds: ^[dynamic]Cloud, cloud_choices: int = 2) {
	cloud_width := f32(rl.GetScreenWidth()) / f32(cloud_choices)
	if cloud_width < (KANJI_FONT_SIZE + MIN_CLOUD_PADDING) {
		spawn_cloud_row(clouds, cloud_choices -1)
		return
	}
	for index in 0..<cloud_choices {
		CLOUD_Y_POS :f32: 1400
		position := rl.Vector2{f32(index) * cloud_width, CLOUD_Y_POS }
		spawn_cloud(clouds, position, width = cloud_width, number = 1, color = rl.WHITE)
	}
}

reset_cloud :: proc(cloud: ^Cloud) {
	cloud.rect.y = 1400
}


draw_cloud :: proc(cloud: Cloud) {
	// Draw the cloud
	rl.DrawTexturePro(cloud_texture, SOURCE_RECT_CLOUD, cloud.rect, {0, 0}, 0, cloud.color)
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
