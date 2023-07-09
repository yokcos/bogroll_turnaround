extends Control


func _ready():
	enable_lowpass()
	
	$list/time.text = "Survival for %s seconds" % floor(Game.time)
	
	History.add_score(Game.time)
	History.save_history()
	
	$list/high.text = "Best time: %s" % floor(History.get_high_score())


func enable_lowpass():
	AudioServer.set_bus_effect_enabled(1, 0, true)
	AudioServer.set_bus_effect_enabled(2, 0, true)

func disable_lowpass():
	AudioServer.set_bus_effect_enabled(1, 0, false)
	AudioServer.set_bus_effect_enabled(2, 0, false)


func _on_retry_pressed():
	disable_lowpass()
	get_tree().change_scene_to_file("res://game.tscn")
	Game.start()

func _on_egress_pressed():
	disable_lowpass()
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")

func _on_timer_timeout():
	for i in $list/buttons.get_children():
		i.show()
	$list/buttons.get_children()[0].grab_focus()
