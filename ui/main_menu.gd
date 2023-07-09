extends Control


func _ready():
	$buttons/begin.grab_focus()


func _on_begin_pressed():
	Game.start()
	get_tree().change_scene_to_file("res://game.tscn")


func _on_egress_pressed():
	if OS.has_feature("web"):
		$label_main.show()
		$label_timer.start()
	else:
		get_tree().quit()

func _on_timer_timeout():
	$label_main.hide()
