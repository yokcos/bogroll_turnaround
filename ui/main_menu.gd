extends Control


func _ready():
	$buttons/begin.grab_focus()


func _on_begin_pressed():
	Game.start()
	get_tree().change_scene_to_file("res://game.tscn")


func _on_egress_pressed():
	get_tree().quit()
