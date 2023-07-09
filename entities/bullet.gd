extends Area2D


var velocity: Vector2 = Vector2()
var acceleration: Vector2 = Vector2()
var duration: float = 10


func _process(delta):
	velocity += acceleration * delta
	position += velocity * delta
	
	duration -= delta
	if duration <= 0:
		queue_free()
