extends Node


var scores: Array = []


func _ready():
	load_history()


func add_score(what):
	scores.append(what)

func get_high_score():
	return scores.max()

func save_history():
	var file = FileAccess.open("user://scores.sav", FileAccess.WRITE)
	file.store_var(scores)

func load_history():
	var file = FileAccess.open("user://scores.sav", FileAccess.READ)
	if file and file.is_open():
		scores = file.get_var()
