extends TextureRect


const tex_active = preload("res://ui/volume_active.png")
const tex_inactive = preload("res://ui/volume_inactive.png")


func _ready():
	Game.mute_changed.connect(update_mute)


func update_mute():
	texture = tex_inactive if Game.mute else tex_active


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			Game.mute = !Game.mute
