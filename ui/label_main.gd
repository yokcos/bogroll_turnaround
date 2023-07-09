extends RichTextLabel


@export var colours: Array[Color] = [Color("bc4a9b"), Color("b4202a")]

var timer: Timer = null
var current_colour: int = 0


func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.start(.1)
	timer.timeout.connect(advance_colour)
	advance_colour()


func advance_colour():
	current_colour += 1
	current_colour = posmod(current_colour, colours.size())
	add_theme_color_override("default_color", colours[current_colour])

