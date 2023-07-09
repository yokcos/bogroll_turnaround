extends Node


var world: Node2D = null
var in_game: bool = false
var time: float = 0
var mute: bool = false: set = set_mute

const obj_fx = preload("res://fx/fx.tscn")

signal mute_changed


func _process(delta):
	if in_game:
		time += delta

func _input(event):
	if event.is_action_pressed("mute"):
		set_mute(!mute)


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


func set_mute(what: bool):
	mute = what
	AudioServer.set_bus_volume_db(1, -1000 if mute else 0)
	mute_changed.emit()
