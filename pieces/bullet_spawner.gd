extends Node2D


@export var total_width = 512
@export var bullet_speed = 300

var age: float = 0

const obj_bullet = preload("res://entities/bullet.tscn")


func _process(delta):
	age += delta


func shoot_random():
	var funcs = [
		shoot_row.bind(
			48 + 640 / (age+5),
			randf(),
			clamp(0.5 + age/60, 0.5, 1),
		),
		shoot_fan.bind(
			int(randf_range( 3, 3 + age/7 )),
			randf_range(0, total_width),
			deg_to_rad(randf_range(5, 10))
		),
		shoot_beam.bind(
			int(randf_range( 3, 3 + age/7 )),
			randf_range(0, total_width),
			randf_range(.7, .99)
		)
	]
	
	var index = randi() % funcs.size()
	funcs[index].call()


func shoot_row(interval: float, offset: float, chance: float):
	var x = offset*interval
	var i = 0
	while x < total_width:
		if randf() < chance:
			var altitude = 0
			if i % 2 == 0:
				altitude = -64
			shoot(Vector2(x, altitude), Vector2(0, bullet_speed))
		
		x += interval
		i += 1

func shoot_fan(bullets: int, where: float, spread: float):
	for i in range(bullets):
		var index = i - float(bullets-1)/2
		shoot(Vector2(where, 0), Vector2(0, bullet_speed).rotated(spread * index))

func shoot_beam(bullets: int, where: float, speed_ratio: float):
	var this_speed: float = bullet_speed
	for i in range(bullets):
		shoot(Vector2(where, 0), Vector2(0, this_speed))
		this_speed *= speed_ratio

func shoot(where: Vector2, velocity: Vector2):
	var new_bullet = obj_bullet.instantiate()
	new_bullet.velocity = velocity
	new_bullet.position = where
	add_child(new_bullet)
	return new_bullet


func _on_timer_timeout():
	shoot_random()
