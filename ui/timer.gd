extends Control


@export var prefix: String = ""
@export var suffix: String = ""

var age = 0


func _process(delta):
	age += delta
	
	var secs = floor(age)
	var mins = floor(secs/60)
	secs = fposmod(secs, 60)
	
	$label.text = "%s%02d:%02d%s" % [prefix, mins, secs, suffix]
