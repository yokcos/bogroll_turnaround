@tool
extends HBoxContainer


@export var button_angle: float = -30
@export var spacing: float = 8


func _notification(what):
	if what == NOTIFICATION_SORT_CHILDREN:
		reposition_children()

func reposition_children():
	var angle: float = deg_to_rad(button_angle)
	var all_kids: Array = []
	
	for i in get_child_count():
		var this_kid = get_child(i)
		if this_kid is Control and this_kid.visible:
			all_kids.append(this_kid)
	
	var total_position: float = 0
	for i in range(all_kids.size()):
		var this_kid: Control = all_kids[i]
		
		var distance0: float = 1000000
		if abs( cos(angle) ) > .001:
			var d0 = this_kid.size.x/2
			distance0 = d0 / abs( cos(angle) )
		
		var distance1: float = 1000000
		if abs( cos(PI/2 - angle) ) > .001:
			var d1 = this_kid.size.y/2
			distance1 = d1 / abs( cos(PI/2 - angle) )
		
		var distance = min(distance0, distance1)
		var interval = distance*2 + spacing
		
		this_kid.pivot_offset = this_kid.size/2
		this_kid.rotation = angle
		this_kid.position.x = total_position
		
		total_position += interval
	
	for i in all_kids:
		i.position.x += size.x/2 - (total_position - spacing)/2
	
	connect_children(all_kids)

func connect_children(all_kids: Array):
	for i in range(all_kids.size()):
		var this_kid: Control = all_kids[i]
		var next_kid: Control = all_kids[posmod(i+1, all_kids.size())]
		
		var this_path: NodePath = next_kid.get_path_to(this_kid)
		var next_path: NodePath = this_kid.get_path_to(next_kid)
		
		this_kid.focus_neighbor_right = next_path
		this_kid.focus_next = next_path
		this_kid.focus_neighbor_bottom = next_path
		
		next_kid.focus_neighbor_left = this_path
		next_kid.focus_previous = this_path
		next_kid.focus_neighbor_top = this_path
