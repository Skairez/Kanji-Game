package game

import rl "vendor:raylib"


Cloud :: struct {
	rect: rl.Rectangle,
	collision_rect: rl.Rectangle,
	number: int,
	color: rl.Color,
}


spawn_cloud :: proc(clouds: &[dynamic]Cloud, position: rl.Vector2, width: f32 = 250, height: f32 = 250, color := rl.WHITE, number := 0) {
	cloud := Cloud{
		rect = rl.Rectangle{position.x, position.y, width, height},
		collision_rect = {},
		number = number,
		color = color,
	}
	update_cloud_collision(&cloud)
	append(clouds, cloud)
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
