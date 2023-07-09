extends Control


@export var prefix: String = ""
@export var suffix: String = ""

var active: bool = true


func _ready():
	Events.death.connect(_on_death)

func _process(delta):
	if active:
		var secs = floor(Game.time)
		var mins = floor(secs/60)
		secs = fposmod(secs, 60)
		
		$label.text = "%s%02d:%02d%s" % [prefix, mins, secs, suffix]


func _on_death():
	active = false
