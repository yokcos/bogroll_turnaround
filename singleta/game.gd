extends Node


var world: Node2D = null

const obj_fx = preload("res://fx/fx.tscn")


func deploy_instance(what: Node2D, where: Vector2):
	if is_instance_valid(world):
		world.add_child(what)
		what.position = where

func deploy_fx(sprite: Texture, where: Vector2, frames: int = 8):
	var new_fx = obj_fx.instantiate()
	new_fx.texture = sprite
	new_fx.hframes = frames
	deploy_instance(new_fx, where)
	return new_fx
