class_name CameraPathConstraint
extends CameraConstraint

# Constrains the camera to a path defiend by a Curve2D

var path : Curve2D
var zoom_range : Vector2

func _init(path, zoom_range):
	self.path = path
	self.zoom_range = zoom_range

func _apply_constraint(position,rotation,zoom) -> Dictionary:
	var ret_pos = path.get_closest_point(position)
	var ret_zooom = clamp(zoom,zoom_range.x,zoom_range.y)
	return {
			"position":ret_pos,
			"zoom":ret_zooom
	}
