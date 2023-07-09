class_name AutoSprite
extends Sprite2D


@export var animation_speed: float = 10

var actual_frame: float = 0


func _process(delta):
	actual_frame += animation_speed * delta
	actual_frame = fposmod(actual_frame, hframes*vframes)
	frame = floori(actual_frame)

