class_name AutoSprite
extends Sprite2D


@export var animation_speed: float = 10
@export var loops: int = -1

var actual_frame: float = 0

signal finished


func _process(delta):
	actual_frame += animation_speed * delta
	if actual_frame >= hframes*vframes:
		finished.emit()
		if loops > 0:
			loops -= 1
			if loops <= 0:
				queue_free()
	actual_frame = fposmod(actual_frame, hframes*vframes)
	frame = floori(actual_frame)

