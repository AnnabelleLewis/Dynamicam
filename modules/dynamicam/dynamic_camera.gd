class_name DynamicCamera
extends Camera2D

# Dynamic camera script
# Moves arround in order to keep all focus points in camera, as well as keeping within
# Defined constraints, as well as applying screen shake

export (float) var zoom_lerp_speed := 1.0
export (float) var position_lerp_speed := 1.0

var _focus_points := [] # Number of focus points, the camera will try to keep all focus points on screen
var _constraints := [] # Active constraint objects, these affect the ideal position
var _screenshake := [] # Active screen shake effects
var _ideal_pos := Vector2.ZERO # Ideal position
var _ideal_zoom := 1.0 # The ideal zoom of the camera, multiplies on top of the focus point zoom

func _enter_tree():
	add_to_group("dynamic_camera")

func _ready():
	global_position = Vector2(1,1)

func _process(delta):
	if Engine.editor_hint:
		return
	
	# Get ideal position based on focus points
	var new_ideal_pos := Vector2.ZERO
	for i in _focus_points:
		new_ideal_pos += i.global_position
	new_ideal_pos = new_ideal_pos / _focus_points.size()
	_ideal_pos = new_ideal_pos
	
	# Lerp zoom
	if _constraints.size() == 0: _ideal_zoom = 1
	var zoom_magnatude := zoom.x
	zoom_magnatude = lerp(zoom_magnatude,_ideal_zoom,delta * zoom_lerp_speed)
	zoom = Vector2(zoom_magnatude, zoom_magnatude)
	
	# Apply constraints
	for i in _constraints:
		var constrained_vars : Dictionary = i._apply_constraint(_ideal_pos,rotation,_ideal_zoom)
		if constrained_vars.has("position"):
			_ideal_pos = constrained_vars.position
		if constrained_vars.has("rotation"):
			rotation = constrained_vars.rotation
		if constrained_vars.has("zoom"):
			_ideal_zoom =  constrained_vars.zoom
	
	# Apply shake
	var shake_offset := Vector3.ZERO
	for i in _screenshake:
		shake_offset += i._apply_shake(delta)
	offset.x = shake_offset.x
	offset.y = shake_offset.y
	rotation = shake_offset.z
	get_tree().get_nodes_in_group("debug_viewer")[0].set_debug_text("shake_offset",String(shake_offset))
	get_tree().get_nodes_in_group("debug_viewer")[0].set_debug_text("shake count",String(_screenshake.size()))
	# Move to ideal position
	get_tree().get_nodes_in_group("debug_viewer")[0].set_debug_text("camera_position",String(global_position))
	get_tree().get_nodes_in_group("debug_viewer")[0].set_debug_text("camera_ideal_position",String(_ideal_pos))
	global_position = lerp(global_position,_ideal_pos,delta * position_lerp_speed)

func add_constraint(constraint):
	_constraints.append(constraint)

func remove_constraint(constraint):
	_constraints.erase(constraint)

func add_focus_point(point):
	_focus_points.append(point)

func remove_focus_point(point):
	_focus_points.erase(point)

func add_screenshake(shake):
	_screenshake.append(shake)

func remove_screenshake(shake):
	_screenshake.erase(shake)
