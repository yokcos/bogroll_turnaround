extends CharacterBody2D


@export var speed = 150
@export var gravity = 200
@export var bump_jump_speed = 100

var flip_int = 1


func _ready():
	update_velocity()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		flip( is_on_floor() )

func _physics_process(delta):
	gravitate(delta)
	
	move_and_slide()
	
	for i in range( get_slide_collision_count() ):
		var this_hit := get_slide_collision(i)
		var hit_dir: float = this_hit.get_normal().x
		hit_dir *= flip_int
		if hit_dir < -0.3:
			flip()
		
		if this_hit.get_normal().y < 0.3:
			velocity.y = min(velocity.y, 0)


func gravitate(delta: float):
	velocity.y += gravity*delta

func flip(jump: bool = true):
	flip_int = -flip_int
	update_velocity()
	if jump:
		velocity.y = -bump_jump_speed

func update_velocity():
	velocity.x = speed * flip_int
	$sprite.animation_speed = 10*flip_int

func die():
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")


func _on_bullet_detector_area_entered(area):
	die()
