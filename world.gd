extends Node2D


func _ready():
	Game.world = self
	
	Events.death.connect(_on_death)


func _on_death():
	$music.stop()
