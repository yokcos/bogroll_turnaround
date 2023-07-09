extends Node


var world: Node2D = null
var in_game: bool = false
var time: float = 0

const obj_fx = preload("res://fx/fx.tscn")


func _process(delta):
	if in_game:
		time += delta


func start():
	time = 0
	in_game = true

func end():
	in_game = false

func deploy_instance(what: CanvasItem, where: Vector2):
	if is_instance_valid(world):
		world.add_child(what)
		what.position = where

func deploy_fx(sprite: Texture, where: Vector2, frames: int = 8):
	var new_fx = obj_fx.instantiate()
	new_fx.texture = sprite
	new_fx.hframes = frames
	deploy_instance(new_fx, where)
	return new_fx
